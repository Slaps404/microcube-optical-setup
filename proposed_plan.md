# Microcube Optical Setup: Proposed Plan and Durable Context

> **Status:** Active design context, pending physical prototype review
> **Date:** 2026-07-31
> **Source:** Full project conversation through 2026-07-31

---

## 1. Objective

Build a parametric, printable OpenSCAD optical assembly around the official
uCube library. The system uses a 50 mm plate beamsplitter, an M37 camera face,
and an adjustable 41 mm two-element collimator/light engine. Success means the
parts align on the cube optical center, export as valid individual STLs and
SCAD entry files, and can be tuned during a physical prototype without
redesigning the whole assembly.

Only the mechanical 3D design is in scope. Raspberry Pi timing, LED driver
electronics, image acquisition, and transillumination/image-combination logic
are out of scope, except that the printed design must eventually permit cable
routing and external thermal hardware.

## 2. Proposed Architecture and Pipeline Steps

1. **Official uCube structure** - Use two identical official uCube shells.
   - Approach: One 68 mm cube is the optical cube and one adjacent 68 mm cube
     is the illumination/focus cell.
   - Inputs: Official 40 mm-clear uCube library in `vendor/uCube`.
   - Outputs: Two printable `official_ucube_shell` parts.

2. **Beamsplitter carrier** - Mount the 50 x 50 x 2.05 mm plate on a flat
   bottom uFace at 45 degrees.
   - Approach: Use a 2.1 mm slot and hidden support rails that stop flush with
     the visible 40 mm opening. The plate fits because its 45-degree projected
     width is about 35.36 mm.
   - Inputs: Measured beamsplitter envelope.
   - Outputs: Centered visible mirror region with supports hidden in side view.

3. **Adjustable illumination rail** - Span the adjacent illumination cell with
   a square rail parallel to the light-propagation axis.
   - Approach: 10.0 mm square rail, 10.3 mm square slider channel, 5 mm slider
     walls, opposing M3 clamps, and a lower-frame placement. The rail is 74 mm
     including provisional 3 mm end overlaps around the 68 mm cell.
   - Inputs: Mentor transcripts, sketches, ruler frames, and official uCube
     dimensions.
   - Outputs: A rail base, movable collimator slider, and separately lockable
     LED/heatsink collar.

4. **Collimator retention** - Hold the measured two-lens assembly without
   point-loading the optics.
   - Approach: 41.2 mm slip-fit bore for the measured 41 mm OD assembly,
     30 mm housing depth, 5 mm front protrusion, 1 mm radial seating ledge,
     formed flat spring, annular load distribution, and removable rear ring.
   - Inputs: 41 mm diameter, 24.1 mm axial thickness, approximately 37.44 mm
     compressed spring diameter, and 1.04 mm spring wire diameter.
   - Outputs: Focus-adjustable collimator barrel aligned to the cube center.

5. **LED and thermal interface** - Keep the source fixed after prototype
   adjustment while allowing the collimator to move.
   - Approach: Separate rail collar around a selected 3 W 3535 LED on a 20 mm
     star MCPCB. Metal spreader and exposed heatsink carry heat, not printed
     plastic. Add diffusion only if a future source has multiple visible point
     emitters; a single LED can illuminate the collimator directly.
   - Inputs: Selected Amazon B0CL726PBP LED reference, 3.0-3.4 V, 700 mA,
     120-degree emission, and 8000-10000 K listing data.
   - Outputs: Mechanically held light source with provisional thermal envelope.

6. **Camera interface** - Attach the supplied 16 mm lens on a movable uFace.
   - Approach: Male M37 x 0.75 printed thread engaging the lens's female front
     or filter thread. The lens's camera-side C-mount is a separate interface.
   - Inputs: 39 mm lens body and 37 mm thread diameter.
   - Outputs: Printable camera face and short thread-fit coupon.

7. **Validation and publishing** - Treat `optical_setup.scad` as the master.
   - Approach: Compile with OpenSCAD hard warnings, export each printable mode,
     confirm `Simple: yes`, and inspect front, back, left, right, top, and
     isometric previews after geometry changes.
   - Inputs: Render modes and shared parameters.
   - Outputs: Curated previews plus matching STL and SCAD files in
     `exports/current`.

## 3. Data Flow

### Inputs

- Official uCube geometry and BOSL2 thread library under `vendor`.
- Measured optical hardware dimensions and mentor sketches/transcripts.
- Provisional LED, thermal, driver, insert, and focal parameters.
- User-selected `render_mode` and focus/fit parameters.

### Transformations

1. Convert physical measurements into named OpenSCAD parameters.
2. Position all optical components on the uCube center axes.
3. Subtract fit bores, slots, cable/fastener paths, and optical apertures.
4. Render assembly references separately from printable bodies.
5. Validate meshes, create previews, and export versioned parts.

### Outputs

- Master parametric model: `optical_setup.scad`.
- Complete and exploded visualization modes.
- Eight current printable STL files and eight matching SCAD entry files.
- Curated GitHub previews under `previews/current`.
- Research notes under `research` and library fixes in `PATCHES.md`.

## 4. Key Decisions and Rationale

| Decision | Chosen approach | Alternatives considered | Rationale |
| --- | --- | --- | --- |
| Cube geometry | Official 40/54/68 mm uCube library | Recreated or scaled cube | Preserves official screw and face compatibility. |
| Beamsplitter placement | 50 mm plate at 45 degrees on a flat face | Put a 50 mm plate axis-aligned inside the 40 mm opening | The projected width fits and the support hardware remains hidden. |
| Illumination packaging | Second uCube cell with an internal rail | 80 mm exposed cantilever rail or integrated fixed pod | Video frames show the rail spanning an additional cube and the 41 mm optic being installed after opening the frame. |
| Focus adjustment | Movable collimator slider, separately lockable LED collar | Fixed spacing, tape-only prototype, or moving the full source stack | Supports empirical tuning while keeping the heat source stable. |
| Slider fit | 10.0 mm rail in a 10.3 mm opening with 5 mm walls | Earlier generic 0.4 mm clearance | These dimensions were explicitly stated in the mentor material. |
| Lens fit | 41.2 mm bore around a measured 41 mm assembly | 0.4 mm total diametral clearance | 0.2 mm total clearance is the later accepted value. |
| Collimator meaning of 24.1 mm | Complete axial thickness | Focal distance | User explicitly corrected this interpretation. |
| Light source | Single 3 W LED on 20 mm star board | Multi-emitter panel, diffuse panel, Thorlabs ACL5040U-A reference | Compact point source suits the collimator; the Thorlabs part was an early reference, not the measured final optic. |
| Camera attachment | Male M37 x 0.75 face thread | Treat the 16 mm C-mount as the face connection | The lens uses C-mount at the camera end, but the printed face engages its female M37 front thread. |
| Preview policy | Only curated previews tracked | Commit every QA render | Keeps GitHub readable; local multi-angle QA remains ignored. |
| Export policy | Version current STL and SCAD pairs | Ignore all generated exports | The user explicitly requested downloadable individual parts on GitHub. |

## 5. Dependencies and Repository State

| Library or tool | Purpose | Constraint or location |
| --- | --- | --- |
| OpenSCAD | Parametric CAD, preview, STL generation | Windows installation at `C:/Program Files/OpenSCAD`; use hard-warning validation. |
| Official uCube library | Cube shells and uFaces | `vendor/uCube`; retain fixes documented in `PATCHES.md`. |
| BOSL2 | Detailed M37 thread geometry | Pinned under `vendor/BOSL2`. |
| GitHub repository | Versioned source and exports | `Slaps404/microcube-optical-setup`, branch `main`. |

Latest committed project context before this document is commit `184549f`.
The current working tree also contains a user change setting `render_mode = 7`;
preserve it unless the user asks to change or commit it.

## 6. Open Questions and Known Risks

- **Physical fit is not yet proven:** OpenSCAD validity does not prove printer
  tolerance, insert fit, face screw alignment, or assembly access.
- **M3 insert geometry is provisional:** Current reference pocket is 4.6 mm
  diameter by 5 mm long and must be matched to the purchased insert.
- **Rail anchor details are provisional:** The 3 mm face overlaps, 20 mm slider
  length, 5 mm barrel wall, and some bridge geometry need prototype review.
- **Optical data is provisional:** Clear aperture 39 mm, EFL 40 mm, BFL 26 mm,
  and 1 mm front-bevel envelope are not confirmed measurements.
- **Thermal stack is provisional:** Current references are a 40 x 40 x 3 mm
  spreader, 36 x 36 x 20 mm heatsink, 22.6 x 9.9 x 8.9 mm driver, and optional
  30 x 10 mm fan. Plastic must not carry LED heat.
- **Spring axial preload is unknown:** The spring is intentionally formed, but
  its compressed axial height and required pressure washer are not measured.
- **Cable path needs physical definition:** Mechanical accommodation for LED
  wiring toward a Raspberry Pi/driver remains incomplete; electrical control
  itself is out of scope.
- **Optical spacing needs empirical tuning:** Earlier 15-20 mm-from-cube goals
  were superseded by the adjustable rail. Lock the final distance only after a
  real illumination/focus test.
- **Face placement is demonstrative:** The camera and light faces may be moved
  to any compatible side as long as the beam path and plate orientation remain
  correct.

## 7. Testing Considerations

| What to test | Method | Success criteria | Phase |
| --- | --- | --- | --- |
| M37 thread | Print `m37_thread_fit_coupon.stl` first | Lens engages smoothly without splitting or excessive wobble | Fit coupons |
| 10/10.3 mm rail | Print a short rail/channel section | Slider moves by hand and locks without rocking | Fit coupons |
| 41.2 mm lens pocket | Print a shallow barrel section | 41 mm assembly inserts without force and has minimal radial play | Fit coupons |
| Spring and retainer | Assemble with pressure washer | Optics are retained without point contact or visible stress | Bench assembly |
| Beamsplitter slot | Test 2.1 mm slot and support position | Plate seats securely; supports remain hidden in straight side view | Bench assembly |
| Official face screws | Mount each custom uFace to a real uCube | Hole pattern and locator fit align without forced screws | Bench assembly |
| Rail travel and enclosure | Install barrel inside auxiliary cube | Barrel clears frame, remains centered, and reaches usable focus range | Bench assembly |
| Illumination uniformity | Sweep collimator position with real LED | Even approximately 30 mm field on the cube face without emitter imaging | Optical prototype |
| Thermal safety | Run LED at intended current with metal thermal path | Printed plastic stays within safe temperature and LED remains stable | Thermal prototype |
| Final mesh validation | OpenSCAD hard warnings plus six-view inspection | Every printable mode reports `Simple: yes` and has no missing/floating geometry | Every CAD revision |
