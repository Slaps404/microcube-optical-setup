# Microcube Optical Setup: Design Record

> **Status:** Active design context, pending physical prototype review
> **Updated:** 2026-07-31
> **Note:** Renamed from `proposed_plan.md`; the design is no longer a proposal.

---

## 1. Objective

A parametric, printable OpenSCAD optical assembly built around the official
uCube library. A 50 mm plate beamsplitter folds an illumination beam into a
camera path. Success means the parts align on the cube optical center, export as
valid individual STLs, and can be tuned on the bench without redesigning the
whole assembly.

Only mechanical 3D design is in scope. Raspberry Pi timing, LED driver
electronics, image acquisition, and image-combination logic are out of scope,
except that the printed design must permit cable routing and external thermal
hardware.

## 2. Cube geometry (MEASURED and locked)

The physical scaled cube is `size = 45, d = 7`. Two numbers that looked
contradictory describe two different features, and both measurements were right.

| Feature | Value |
| --- | --- |
| Clear square through-hole | 45 |
| Frame feature `d` | 7 |
| Overall cube | 73 |
| uFace plate | 59 x 59 x 3.5 |
| Corner screw centers (uFace mounting) | +/-26 |
| Mid-edge cube-to-cube screws | +/-29.5 |
| Outer surface to inner opening edge | 14 (`2d`) |
| Screw-pad inset width | 10.5 (`1.5d`) |
| Screw spec | `screwR 1.75, capR 3, capH 2.5, insertH 5, insertR 2` |
| faceGap | 0.4 |

The through-hole is `size` = 45. The wider inside-face inset is `size + 2d` = 59,
which measures about 60 by hand. `Scaled_uCube.scad` in Downloads carries
`mySize = 60`, which conflates the two and is **stale**. Do not treat it as a
source of truth.

## 3. Architecture

### Optical cube
Official `uCube` shell. The bottom face carries the beamsplitter at 45 degrees,
one side face carries the M37 camera interface, and another side face carries the
illumination cell.

### Illumination cell (Path B)
A **custom light-tight box that bolts into one uFace pocket**, not a second
official cube. Reason: an official 73 mm cube has 14 mm end walls, so its
interior is only 45 mm along the light axis, which cannot hold a 25 mm sleeve
plus focus travel plus the LED post. Bolting through a uFace keeps official
screw compatibility while letting the box be as long as the optics need.

Prints as **two U shells**:
- **Bottom U:** mating plate, near end wall with the light port, floor, far end
  wall, and the integral rail.
- **Top U:** both side walls plus the roof, dropping on as a lid.

Assembly and focus adjustment happen by lifting the lid, so there is no access
slot and no cover strip. A tongue centered in each side wall crosses the seam so
light cannot pass straight through the joint.

Interior is 70 x 52 x 59 mm with 36 mm of sleeve focus travel.

### Rail and sliders
**One** centered rail runs the full interior length along the light axis,
10.5 x 9 mm. Its top is *derived*, not chosen: it sits `harness_seat_clearance_mm`
below the sleeve underside so the bore stays exactly on the beam axis, which was
the stated priority over rail height.

Two sliders share one `harness_foot` module, so they grip identically: a
slip-fit U straddling the rail with two opposing M3 set screws in heat-set
inserts pressing the rail flanks.

- **Slider 1, lens sleeve** (one printed part): bore 41, wall 2, OD 45, depth 25.
  A 1 mm internal lip at the cube-facing end stops the purchased tube; the tube
  loads from the open rear and a spring clip retains it. **No groove is cut.**
- **Slider 2, LED post:** a flat plate with its pad on the beam axis and a cable
  pass-through below the star footprint.

### Optics
The two lenses ride on spring clips inside a **purchased 40.0 mm lens tube**
(measured, smooth outer surface). Our sleeve holds that tube. We neither model
nor machine the tube.

### Light source
Amazon ASIN B0CL726PBP: 3 W 3535 emitter on a 20 mm star MCPCB, 3.0-3.4 V at
700 mA, 120 degrees, 8000-10000 K. For v1 the star is taped or glued to the
post. **v1 strobes the LED, so no secondary heatsink is modeled** and the star's
own MCPCB is the only thermal mass. Capturing the star's edges or adding a
glued-on heatsink is a v2 change to one small part, not to the cell.

A 120 degree emitter spills a cone far wider than the lens, so **closer is
brighter**. Travel toward zero gap is worth more than travel past 25 mm.

### Camera interface
Male M37 x 0.75 printed thread engaging the lens's female front/filter thread.
The lens's camera-side C-mount is a separate interface.

## 4. Key decisions and rationale

| Decision | Chosen approach | Rationale |
| --- | --- | --- |
| Cube size | `size = 45, d = 7` | Physical measurement. The 60 in the Downloads file is the inset, not the bore. |
| Screw counterbores | Z mirror in `official_face_at_inside_plane()` | The vendor uFace opens counterbores on plate local +Z, but every custom face builds toward the cube interior on +Z, so cap screws could not seat from outside. One mirror fixes all five faces with no vendor edits. `uHolder.scad` performs the same flip. |
| Illumination packaging | Custom box on a uFace (Path B) | A second official cube has only 45 mm of usable length. Path B also gives 2 seams instead of 6 face perimeters to light-seal, a solid floor for the rail, and an interior we control. |
| Cube rescaling | Rejected | Print time and setup time are the binding constraints. Prefer local geometry changes. |
| Rail count | One centered rail | It bridges the center of one end to the center of the other, which also dissolves any collision with the corner inserts. |
| Rail height | Derived from the sleeve | Centering the bore on the beam axis outranks rail height. |
| Lens retention | Purchased tube, spring clip, 1 mm lip | Tube-in-tube beats machining our own bore for manufactured lenses. A groove was considered and explicitly rejected. |
| Sleeve wall | 2 mm | Path B frees the interior size, so the earlier 1 mm workaround is unnecessary and would print weak. |
| Focus adjustment | Two independently clamped sliders | Both LED and lens positions must be tuned empirically. |
| Thermal design | None in v1 | Strobing removes the need, and the heatsink is unpurchased and unmeasured. Building a 100 mm enclosure around guessed dimensions is the expensive kind of guess. |
| Harness wall | 6 mm | A 5 mm heat-set insert cannot live in a 3 mm wall. Enforced by assert. |
| Which cube face | Any of the four side faces | The light axis must be horizontal so the sliders sit on a floor. The cube is 4-fold symmetric, so the printed part is identical whichever side is chosen. Picked at assembly time, not design time. |

## 5. Dependencies and repository state

| Library or tool | Purpose | Location |
| --- | --- | --- |
| OpenSCAD | Parametric CAD, preview, STL | `C:/Program Files/OpenSCAD`; validate with hard warnings. |
| Official uCube library | Cube shells and uFaces | `vendor/uCube`; fixes documented in `PATCHES.md`. |
| BOSL2 | M37 thread geometry | Pinned under `vendor/BOSL2`. |
| GitHub | Source and exports | `Slaps404/microcube-optical-setup`, branch `main`. |

## 6. Open questions and known risks

- **Nothing has been printed.** OpenSCAD validity does not prove printer
  tolerance, insert fit, screw alignment, or assembly access.
- **Sleeve depth 25 mm is provisional.** Confirm against the real tube.
- **M3 insert geometry is provisional:** 4.6 mm diameter by 5 mm, and must be
  matched to the purchased insert.
- **Seam clearances are untested.** The 0.25 mm lid slip fit and the
  tongue-and-groove both need a printed coupon.
- **Light-tightness is unproven.** The tongue blocks the straight path, but
  printed PLA walls glow, so plan on 3 perimeters or a matte black interior.
- **The LED post is a thin tall cantilever.** It carries only a 2 g board, but
  check stiffness and print quality on the first article.
- **Optical data is provisional:** clear aperture, EFL 40 mm, and BFL 26 mm are
  not confirmed measurements.
- **The cell bottom sits 0.5 mm below the cube bottom**, since the floor wall is
  4 mm where 3.5 mm would be flush. Cosmetic on a benchtop.
- **Cable path needs physical definition** beyond the pass-through notch.
- **Focus distances must be set empirically.** The ~2 cm LED-to-lens figure is a
  guess, not a measurement. Both sliders adjust, so nothing depends on it.
- **Exports under `exports/current` are stale.** They predate the 45 mm
  migration, the counterbore fix, and the new cell.

## 7. Testing considerations

| What to test | Method | Success criteria | Phase |
| --- | --- | --- | --- |
| Face screws | Mount one custom uFace on the real cube | Counterbores face outward and cap screws seat fully | Fit coupon, do this first |
| Rail and harness | Print a short rail section and one foot | Foot slides by hand and clamps without rocking | Fit coupon |
| Sleeve bore | Print a shallow sleeve ring | The 40.0 mm tube inserts without force, minimal play | Fit coupon |
| M37 thread | Print `m37_thread_fit_coupon.stl` | Lens engages smoothly without splitting | Fit coupon |
| Lid seam | Print short sections of both U shells | Lid drops on, tongue seats, no daylight through the joint | Fit coupon |
| Beamsplitter slot | Test the 2.1 mm slot | Plate seats securely, supports hidden in side view | Bench assembly |
| Light-tightness | Assemble, light the LED, darken the room | No visible leak at seams or through the walls | Bench assembly |
| Illumination | Sweep both sliders with the real LED | Even field on the cube face without imaging the emitter | Optical prototype |
| Mesh validation | Hard warnings plus six-view inspection | Every printable mode reports `Simple: yes` | Every CAD revision |

## 8. Render modes

| Mode | Part |
| --- | --- |
| 0 | Complete assembly |
| 1 | Beamsplitter mounting face |
| 2-4 | Legacy compact light chamber (retained, not the current design) |
| 5 | Camera face |
| 6 | Camera thread test coupon |
| 7 | Exploded assembly |
| 8 | Inspection assembly |
| 9 | Official uCube shell |
| 10 | Illumination cell bottom U |
| 11 | Illumination cell top U (lid) |
| 12 | Lens sleeve slider |
| 13 | LED post slider |
| 14 | Cell assembly |
| 15 | Cell assembly, lid off |
