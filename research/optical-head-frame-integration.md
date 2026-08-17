# Optical head frame integration concepts

**Status:** Brainstorming record, not an adopted geometry decision  
**Date:** 2026-08-16

## Problem

The current lab setup clamps the 16 mm lens. The uCube screws onto the front of
the lens, and the illumination cell bolts to the uCube. This makes the lens
barrel the structural spine for the entire optical head.

That arrangement has three problems:

1. The camera, uCube, and illumination cell form a long twisting lever around
   the lens clamp.
2. Tightening or bumping any downstream part can rotate or tilt the optical
   assembly.
3. The frame does not independently constrain the camera axis, cube position,
   or illumination axis.

The lens connection should locate the optical path. It should not be the main
structural load path.

## Design principle

Use **two strong load paths and one shared post datum**:

- Support the uCube directly from a broad adapter on the vertical extrusion.
- Support the camera directly from a separate horizontal extrusion and camera
  plate above the cube.
- Keep the camera lens axis vertical and coaxial with the center of the uCube.
- Keep the lens-to-uCube connection for coaxial optical alignment and light
  sealing, with little or no structural load.
- Let the uCube side face establish the illumination axis at 90 degrees to the
  vertical camera axis.

The camera and uCube are not orthogonal to each other. Their centers are on the
same vertical optical axis. The orthogonal relationship is between that camera
axis and the horizontal illumination axis.

```mermaid
flowchart TD
    P[Vertical extrusion post] --> A[Wide uCube backplate and lower saddle]
    P --> E[Horizontal camera extrusion]
    E --> G[Opposed corner brackets and gussets]
    G --> C[Horizontal camera plate]
    C --> B[IMX477 board or captive tripod cradle]
    B --> L[16 mm lens pointing down]
    A --> U[uCube]
    L -. coaxial optical connection, not main load .-> U
    U --> I[Illumination cell on adjacent cube face]
    I -. 90 degrees .-> L
    P --> R[Separately supported horizontal accessory rail]
    R --> K[Illumination modules, including Kohler]
    K --> I
```

## Recommended concept

### 1. Broad post interface, not a one-tab hanger

The small single contact shown in the first concept is not acceptable. Both
supports must spread load across the vertical extrusion.

The camera arm should meet the post with two opposed metal corner brackets or
gussets, preferably backed by a plate that uses multiple T-nuts. The uCube
adapter should contact the post over a tall, flat region with upper and lower
fasteners. If the post exposes two slot columns, use both columns to create a
rectangular four-bolt pattern.

The screws provide clamp force. Broad mating faces, gussets, shoulders, and
keys should define squareness and carry shear. One screw or one small printed
tab should not define the pose of either optical assembly.

The stand uses standard 2020 T-slot extrusion, so the outside section is 20 x
20 mm with one centered slot on each face. A single face therefore cannot
provide a two-column bolt pattern. Use two vertically separated fasteners in
the rear slot plus wraparound features or fasteners into the side slots.

### 2. Direct post-mounted uCube adapter

The preferred cube support is a replacement rear uFace that grows into a
post-mounting backplate. It uses the existing four M3 face screws on a 52 mm
square pitch, so the uCube remains registered by its normal face geometry. The
plate extends above and below the 73 mm cube so its T-slot bolts remain
accessible after the cube is installed.

Add a short horizontal saddle under the cube and two shallow side cheeks:

- The saddle carries gravity in compression instead of asking the four M3
  screws to carry all weight in shear.
- The side cheeks register the 73 mm cube and resist yaw.
- The four uFace screws clamp the cube against the adapter.
- Upper and lower post bolts, widely separated along the post, resist pitch.
- Two wraparound post saddles, one above and one below the cube center, contact
  the front and side faces of the 20 x 20 mm post. Side-slot fasteners or fitted
  side walls resist roll and yaw better than relying on friction in one slot.

This adapter belongs on an unused face, preferably opposite the illumination
cell. It must leave the top camera port, bottom/sample path, illumination port,
and all needed face screws accessible.

A machined aluminum backplate with printed locator blocks is the stiffest
version. A fully printed PETG or nylon saddle is appropriate for the first fit
test, but it should have broad ribs and should not be treated as a proven final
instrument mount until deflection is measured.

The uCube becomes the local optical datum. Its vertical centerline defines the
camera axis, and its side face defines the horizontal illumination axis.

### 3. Independent camera support on a horizontal extrusion

Attach a horizontal extrusion above the uCube. Join it to the vertical post
with opposed corner brackets or gussets on both sides, not one small connector.
A camera plate spans between two brackets below the horizontal extrusion and
supports the IMX477 camera while its 16 mm lens points vertically downward into
the top uCube face.

Two camera attachment approaches are viable:

| Approach | Strengths | Risks | Best use |
| --- | --- | --- | --- |
| Four PCB holes on 30 mm square pitch | Positive anti-rotation, compact, repeatable | Requires correct standoffs, screw length, back-side keepouts, and cable access | Final rigid instrument |
| Captive tripod-foot cradle with one 1/4-20 bolt | Does not load the PCB, fast to install | The screw alone is one point, so the cradle must add a broad base and two side cheeks | First prototype or removable camera |

The tripod version is not a single-contact mount if the foot sits in a fitted
pocket. The bolt supplies clamp force, while the base plane and two locating
walls prevent yaw and rotation.

For the final fixed setup, the four PCB holes are the more direct way to make
the camera body independently rigid. Use four equal-height standoffs and verify
component clearance on the rear of the board.

### 4. Avoid fighting constraints

The M37 lens-to-uCube thread and the separate camera plate can both constrain
the same camera position. If they are tightened while misaligned, they can bend
the camera plate, load the lens barrel, or tilt the uCube.

Use this assembly sequence:

1. Rigidly mount and square the uCube on the post adapter and lower saddle.
2. Loosely mount the IMX477 camera in the camera plate.
3. Lower or slide the camera plate until the 16 mm lens engages the top uCube
   interface without side load.
4. Use slots or thin shims to remove any gap and align the support.
5. Tighten the camera support while watching for image shift.
6. Mark the final shim stack or slot position for repeatable reassembly.

The camera support should be stiff after tightening, but vertically adjustable
during first alignment. Slots in the paired camera brackets, or shims under the
camera plate, prevent the support from steering the lens.

### 5. Illumination cell support

The illumination cell should remain bolted to the adjacent uCube face. That
face establishes its 90-degree relationship to the camera axis.

If physical testing shows far-end sag, add a light vertical hanger from the
head plate to the far end of the cell. Use a slot at the hanger so it carries
vertical weight without pulling the cell sideways or redefining its optical
axis.

### 6. Expansion interface for Köhler illumination

Do not make the uCube carry a long train of future illumination optics. Add a
horizontal accessory rail whose centerline is fixed to the center of the
illumination uFace, but whose structural load returns directly to the vertical
post or base frame.

The uFace then provides optical registration and light sealing. The rail carries
the mass and bending moment.

A future epi-illumination train could provide independently sliding modules for:

1. LED or other source.
2. Collector lens.
3. Field diaphragm.
4. Relay optics.
5. Aperture diaphragm at the appropriate conjugate plane.
6. Condenser or final coupling lens into the uCube.

Exact order and spacing must follow the chosen Köhler optical prescription. The
mechanical requirement now is to preserve enough rail length and give every
module the same horizontal optical center height.

Possible rail standards:

| Rail | Strengths | Risks |
| --- | --- | --- |
| Two parallel cage rods | Strong control of rotation and optical center | Requires accurate rod spacing and parallelism |
| Dovetail optical rail | Rigid and easy to reposition | Purchased hardware can be expensive |
| 2020 extrusion with registered carriages | Matches the stand and is inexpensive | A single slot does not guarantee optical-axis rotation without a keyed carriage |

The most important requirement is two separated locating features. A single
round rod or one loose T-slot leaves module roll underconstrained.

Reserve a similar vertical expansion zone above the uCube. A removable spacer
or vertically sliding camera plate would allow future filters, analyzers, or
relay optics between the cube and camera without redesigning the post mounts.

## Structural load paths

- Camera: camera board or tripod cradle -> camera plate -> paired brackets ->
  horizontal extrusion -> opposed post gussets -> vertical post.
- uCube and beamsplitter: cube body -> rear mounting uFace -> lower saddle and
  tall backplate -> multiple T-nuts -> vertical post.
- Illumination cell: uCube face -> post-mounted cube adapter -> vertical post.
- Optional cell support: far-end hanger -> post or base frame.
- Future illumination train: accessory rail -> post or base frame.
- Lens connection: optical centering and sealing, not the primary support.

## Orthogonality checks

Mechanical squareness is necessary but not sufficient. Validate in this order:

1. Check the uCube backplate against the post with a machinist square.
2. Check the horizontal camera extrusion at 90 degrees to the post.
3. Check that the camera plate is parallel to the top uCube face.
4. Confirm the uCube is seated on its saddle and side registers before
   tightening screws.
5. Project or image a centered target through the system and watch for image
   shift while tightening the camera support.
6. Confirm the vertical camera axis is centered through the top and bottom cube
   openings.
7. Confirm the illumination axis enters through the center of its horizontal
   uCube face at 90 degrees to the camera axis.
8. Recheck after attaching the illumination cell, because its cantilever load
   can reveal cube or arm flex.

## Stability check before calling the mount complete

The image is not enough to certify stiffness. The post profile, arm length,
bracket material, fasteners, and real assembly mass are still unknown.

The current active STL set has about 285 cm3 of printed material including the
uCube shell. At 1.24 g/cm3 this is roughly 353 g of PLA at 100 percent material
density. This is only a mesh-volume estimate. It does not include the camera,
lens, glass, LEDs, wiring, fasteners, unused faces, or slicer-dependent infill
and wall settings. Weigh the complete physical head instead of using this
estimate for the final calculation.

For each cantilevered load, calculate the post-joint moment from
`moment = mass x 9.81 x horizontal reach`, using kilograms and meters. Then use
the real extrusion manufacturer's section data and the actual bracket pattern
to check deflection. Do not certify a profile guessed from the screenshot.

Physical proof test:

1. Square and focus the complete system on a fixed crosshair target.
2. Record the target position in camera pixels.
3. Add a temporary 1.5 times service load at the real center-of-mass location.
4. Record camera-to-cube image shift, not only motion of the extrusion tip.
5. Remove the load and confirm the image returns with no permanent shift.
6. Attach and remove the illumination cell and repeat, because it produces the
   strongest twisting load on the cube adapter.
7. Recheck every T-slot fastener after the first several assembly cycles.

Set the allowable pixel shift from the imaging experiment. A made-up mechanical
deflection limit would not prove that the optical result is acceptable.

Also inspect the upright-to-base joint. If the visible triangular plate is the
only base gusset, add an opposed gusset or backing plate so the whole post does
not rack even when the optical head itself is stiff.

## Pulled reference models

Reference meshes are stored under
`vendor/raspi-hq-camera-reference/`:

- `HQ_Camera_model.stl`
- `Lens_16mm_model.stl`
- `raspi_HQ_cam_and_16mm_lens.stl`

They came from David Crook's community OpenSCAD model at commit
`4951fc2d117aa58dec62e8bc2101ca5e6f0dc89c` and are licensed CC BY-SA
4.0. They are reference envelopes, not official manufacturing CAD.

The main dimensions were checked against Raspberry Pi's current documents:

- HQ camera PCB: 38 x 38 mm.
- Four board holes: 30 mm square pitch.
- Tripod thread: 1/4-20 UNC.
- 16 mm lens: approximately 39 mm diameter by 50 mm nominal length.

## Dimension authority

The concept render deliberately separates known component geometry from
provisional support geometry.

| Item | Current value | Authority | Status |
| --- | ---: | --- | --- |
| uCube overall size | 73 mm | `DESIGN.md` and current source | Locked physical measurement |
| uCube clear opening | 45 mm | `DESIGN.md` and current source | Locked physical measurement |
| uFace size | 59 x 59 x 3.5 mm | `DESIGN.md` and current source | Locked project geometry |
| uFace corner screw pitch | 52 mm square | `DESIGN.md` and current source | Locked project geometry |
| IMX477 HQ camera PCB | 38 x 38 mm | Raspberry Pi drawing | Official |
| Camera PCB holes | 30 mm square pitch, nominal 2.5 mm | Raspberry Pi drawing | Official, verify the physical board before screw selection |
| Camera tripod thread | 1/4-20 UNC | Raspberry Pi drawing | Official |
| 16 mm lens envelope | 39 mm diameter x 50 mm nominal length | Raspberry Pi documentation | Official envelope |
| Combined camera and lens mesh | 39 x 51.7 x 72.0222 mm bounding box | Imported community reference mesh | Packaging reference only |
| Beamsplitter | 50 x 50 x 2.5 mm | Physical measurement recorded in this project | Measured |
| Vertical post and camera-arm envelope | 20 x 20 mm, one centered slot per face | User identification as standard 2020 T-slot | Confirmed outside envelope |
| Slot opening and compatible T-nut | Commonly 6 mm slot with M5 hardware | Manufacturer-dependent 20-series interface | Verify the physical nut before modeling |
| Post-adapter height, thickness, and T-slot fasteners | Unknown | Depends on measured stand and chosen material | Concept only |
| Köhler rail spacing and module lengths | Unknown | Depends on the optical prescription | Concept only |

The black camera/lens mesh, uCube shell, and blue illumination cell in the
first concept render use the available reference geometry. Its orange one-tab
C-frame is rejected because it does not spread load into the vertical post.
It is not a printable support part and should not be used for fabrication.

Sources:

- [Raspberry Pi HQ camera mechanical drawing](https://datasheets.raspberrypi.com/hq-camera/hq-camera-mechanical-drawing.pdf)
- [Raspberry Pi camera documentation](https://www.raspberrypi.com/documentation/accessories/camera.html)
- [Community reference model source](https://github.com/idcrook/psychic-winner/tree/main/raspi_cam_hq_models)

## Measurements needed before CAD

- Confirm the horizontal arm is also 2020, not only the vertical post.
- Measure the slot-mouth width and identify the existing T-nut thread. Start
  from a 6 mm slot and M5 only after physically confirming the hardware.
- Confirm which front and side post slots remain accessible at the cube height.
- Maximum possible vertical spacing between the upper and lower cube-adapter
  bolts.
- Available horizontal camera-arm length above the uCube.
- Desired cube center height above the sample.
- Physical camera PCB hole diameter and rear-component keepouts.
- Camera ribbon-cable exit direction and minimum bend clearance.
- Actual lens-to-camera assembled length at the working focus setting.
- Accessible top-face screw locations on the assembled uCube.
- Total mass and observed sag of the illumination cell.
- Desired accessory-rail standard and the maximum planned Köhler train length.
- Required clear aperture for future diaphragms, filters, and relay optics.

## First prototype boundary

Model only these pieces first:

1. One rear uFace adapter with a lower saddle, side registers, and tall post
   mounting tabs.
2. One horizontal camera extrusion joined to the post by opposed brackets or
   gussets.
3. One vertically adjustable camera plate, initially using either the
   four board holes or a captive tripod-foot cradle.
4. One removable illumination-rail datum aligned to the center of the active
   horizontal uCube face.

Do not redesign the beamsplitter face, M37 camera face, or illumination cell
until the shared-frame support is physically checked.
