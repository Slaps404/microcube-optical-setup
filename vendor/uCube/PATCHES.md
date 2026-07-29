# Vendored uCube snapshot

Source: <https://github.com/mdelmans/uCube>

Upstream commit: `0c0b62ce9526e363f4244a37773a0726b9ade3f8`

This directory contains the official uCube source with two OpenSCAD
compatibility fixes:

- `Parts/uCubeCore.scad`: pass `[0,0,0]` explicitly to `corner3`.
- `uCubeUtil.scad`: correct the final `mirror` vector from `[[1,0,0]]` to
  `[1,0,0]`.

The geometry and default uCube dimensions are otherwise unchanged.
