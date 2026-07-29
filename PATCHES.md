# Local compatibility patches

The vendored µCube 1.0 library is GPL-3.0 and originates from
`https://github.com/mdelmans/uCube`.

Two compatibility corrections are applied for OpenSCAD 2021.01:

- `trippleMirror` now passes a three-number vector to `mirror`.
- `uCube` passes `[0, 0, 0]` to `corner3` instead of omitting its required
  translation vector.

These preserve the library's intended transform operations and remove modern
OpenSCAD warnings. Keep this file updated if the vendored library changes.
