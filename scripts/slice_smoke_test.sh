#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
stl_dir="${1:-$root/build/stl}"
output_dir="${2:-$root/build/gcode}"

if [[ -n "${PRUSA_SLICER:-}" ]]; then
  slicer="$PRUSA_SLICER"
elif command -v prusa-slicer >/dev/null 2>&1; then
  slicer="$(command -v prusa-slicer)"
elif [[ -x /Applications/PrusaSlicer.app/Contents/MacOS/PrusaSlicer ]]; then
  slicer=/Applications/PrusaSlicer.app/Contents/MacOS/PrusaSlicer
else
  echo "PrusaSlicer was not found. Set PRUSA_SLICER to its CLI executable." >&2
  exit 1
fi

mkdir -p "$output_dir"

slice() {
  local name="$1"
  local profile="$2"
  shift 2
  "$slicer" --load "$root/slicer/$profile" "$@" \
    --export-gcode \
    --output "$output_dir/$name.gcode" \
    "$stl_dir/$name.stl" 2>&1 | tee "$output_dir/$name.log"
  test -s "$output_dir/$name.gcode"
}

slice illumination_cell_bottom_u ender3v2-pla-pro-04.ini \
  --support-material --support-material-auto --support-material-buildplate-only
slice illumination_cell_top_u ender3v2-pla-pro-04.ini --rotate-x 180
slice beamsplitter_mounting_face ender3v2-pla-pro-04.ini
slice official_ucube_shell ender3v2-pla-pro-04.ini \
  --support-material --support-material-auto --support-material-buildplate-only
slice lens_sleeve_slider ender3v2-pla-pro-02.ini \
  --rotate-y 90 --brim-width 3 \
  --support-material --support-material-auto --support-material-buildplate-only
slice led_post_slider ender3v2-pla-pro-02.ini --brim-width 3
slice m37_camera_mounting_face ender3v2-pla-pro-02.ini
slice m37_thread_fit_coupon ender3v2-pla-pro-01.ini --brim-width 2

for gcode in "$output_dir"/*.gcode; do
  echo "$(basename "$gcode"):"
  grep -E '^; (filament used \[g\]|estimated printing time \(normal mode\)|nozzle_diameter|layer_height) =' "$gcode"
done
