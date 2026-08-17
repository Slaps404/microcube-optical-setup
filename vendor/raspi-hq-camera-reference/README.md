# Raspberry Pi HQ camera reference models

Reference-only mesh models for packaging and mount-clearance work:

- `HQ_Camera_model.stl`: Raspberry Pi HQ camera with the tripod foot.
- `Lens_16mm_model.stl`: 16 mm C-mount telephoto lens.
- `raspi_HQ_cam_and_16mm_lens.stl`: assembled camera, C-CS adapter, and lens.

These are community reference models, not official Raspberry Pi CAD. They were
copied from David Crook's `idcrook/psychic-winner` repository at commit
`4951fc2d117aa58dec62e8bc2101ca5e6f0dc89c`:

<https://github.com/idcrook/psychic-winner/tree/main/raspi_cam_hq_models>

The imported files are licensed CC BY-SA 4.0. See `LICENSE.txt`.

## Dimensional checks

The meshes agree with the main official packaging dimensions used for mount
concepts:

- HQ camera PCB: 38 x 38 mm.
- Four PCB holes: 30 mm square pitch, nominal 2.5 mm diameter in the current
  official CS-mount drawing.
- Tripod thread: 1/4-20 UNC.
- 16 mm lens: 39 mm maximum body diameter by 50 mm nominal length.

Official references:

- <https://datasheets.raspberrypi.com/hq-camera/hq-camera-mechanical-drawing.pdf>
- <https://www.raspberrypi.com/documentation/accessories/camera.html#recommended-lenses>

Use the official drawings and the physical parts for fit-critical dimensions.
The meshes are suitable for interference checks and concept previews, not for
manufacturing the camera or lens interfaces without measurement.

## Mesh notes

The camera mesh is one watertight surface component. The lens and combined
assembly each contain four separate watertight components because the model
keeps the lens rings and camera pieces as disconnected reference solids.
