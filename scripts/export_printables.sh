#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
output_dir="${1:-$root/build/stl}"
openscad_bin="${OPENSCAD:-openscad}"

parts=(
  illumination_cell_bottom_u
  illumination_cell_top_u
  lens_sleeve_slider
  led_post_slider
  beamsplitter_mounting_face
  m37_camera_mounting_face
  m37_thread_fit_coupon
  official_ucube_shell
)

mkdir -p "$output_dir"
for part in "${parts[@]}"; do
  log="$output_dir/$part.log"
  "$openscad_bin" --hardwarnings \
    -o "$output_dir/$part.stl" \
    "$root/exports/current/$part.scad" 2>&1 | tee "$log"
  grep -q "Simple:[[:space:]]*yes" "$log"
done

python3 "$root/scripts/check_stl.py" "$output_dir"/*.stl
