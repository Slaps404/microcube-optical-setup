# Ender 3 V2 slicer smoke-test profiles

These are resolved PrusaSlicer profiles for an Ender 3 V2 using generic PLA
Pro assumptions. They exist to make slicing repeatable and to catch impossible
toolpaths, bed-size violations, disconnected meshes, and support requirements.

| Profile | Nozzle | Layer height | Intended parts |
| --- | ---: | ---: | --- |
| `ender3v2-pla-pro-04.ini` | 0.4 mm | 0.20 mm | Cell shells, cube, beamsplitter face |
| `ender3v2-pla-pro-02.ini` | 0.2 mm | 0.10 mm | Sliders and M37 camera face |
| `ender3v2-pla-pro-01.ini` | 0.1 mm | 0.05 mm | M37 thread-fit coupon |

All profiles use 205 C nozzle, 60 C bed, and three perimeters. Confirm the
temperature range printed on the actual PLA Pro spool before printing. These
profiles are smoke-test defaults, not a substitute for first-layer, flow,
retraction, and dimensional calibration on the physical printer.

Run:

```sh
scripts/export_printables.sh
scripts/slice_smoke_test.sh
```

Generated G-code is written under `build/` and intentionally ignored by Git.
Do not send CI-generated G-code directly to a printer without previewing it.
