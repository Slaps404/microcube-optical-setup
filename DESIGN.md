# Microcube Optical Setup: Design Record

> **Status:** Active design context, pending physical prototype review
> **Updated:** 2026-08-14
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
the top face carries the M37 camera interface for the downward-looking camera,
and one side face carries the horizontal illumination cell.

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

The top U includes passive ventilation near the LED end: five 20 x 3 mm roof
exhaust slots with 45-degree internal louvers, plus four vertical 12 x 3 mm
intake slots low on the positive-Y wall behind an offset internal shroud. The
separated low intake and high exhaust encourage passive convection. Both vent
groups remove the direct perpendicular light path, but physical light-leak and
temperature tests are still required. The side shroud has a 5.5 mm air gap,
giving its clear downward plenum about 146 mm2 of area versus 144 mm2 across
the four intake slots, so the hidden channel does not choke the visible slots.

Assembly and focus adjustment happen by lifting the lid, so there is no access
slot or cover strip. The top U is intentionally only the roof and upper side
walls, with no end-wall tabs or cross-pieces.

The enclosure is 73 mm wide at the body but retains the standard 59 mm uFace
mounting plate and its unchanged screw pattern. The outer cell is 190 mm long,
giving the full-length rail 180 mm of clear sliding room. This is based on the
roughly 170 to 175 mm occupied span in the bench reference photo, rounded up to
leave a little positioning margin.

The cell uFace uses the same cube-opening datum as the other custom faces. A
44.2 mm square, 1 mm-deep bridge crosses the cell-wall/uFace interface and
overlaps each solid by 0.5 mm. This makes the mount and bottom shell one
printable part while retaining 0.4 mm clearance per side in the measured 45 mm
cube opening.

### Rail and sliders
**One** centered rail runs the full interior length along the light axis,
10.5 x 9 mm. Its top is *derived*, not chosen: it sits 1.5 mm below the sleeve
underside to leave a solid harness roof while the bore stays exactly on the beam
axis. The slot roof rests directly on the rail top, with no vertical clearance.

Two sliders share one `harness_foot` module, so they grip identically: a
nominal-zero-clearance U straddling the 10.5 mm rail with two opposing M3 set
screws in heat-set inserts pressing the rail flanks. The modeled slot is now
10.5 mm wide. The printed rail and harness showed approximately 10.4 mm and
11 mm respectively, so this revision is an empirical tightening experiment;
print a short coupon and file only if needed.

The harness side runners rest directly on the bottom-U floor. Their nominal
slot depth is 9 mm around the 9 mm rail, so the slider seats on both the floor
and the rail top.

The latest printed fit measured a 10.4 mm rail width and 10.85 mm harness slot
width, or 0.45 mm total lateral clearance. It also measured 9 mm rail depth
against the original 7 mm harness slot depth; the revised 9 mm slot closes
that unsupported lower span and brings the runners onto the floor datum.

The sleeve harness spans the full 25 mm sleeve depth, making both end faces
coplanar and centering the modeled mass over its rail contact for support-free
printing and stable unclamped placement. The LED upper geometry remains offset
toward positive X relative to its harness so the harness front is flush with
the LED pad face. The sleeve and LED optical planes remain fixed.

Each insert bore is intentionally stepped. The 4.0 mm by 5 mm insert pocket
ends at a 1 mm backing shoulder, followed by a 3.2 mm screw passage to the rail.
The 0.4 mm radial shoulder stops the insert and keeps it out of the sliding
slot. Both slider types use the shared `m3_insert_diameter_mm` and
`m3_insert_length_mm` parameters. Final fit still requires a coupon with the
purchased insert.

- **Slider 1, lens sleeve** (one printed part): bore 41, wall 2, OD 45, depth 25.
  A 1 mm internal lip at the cube-facing end stops the purchased tube; the tube
  loads from the open rear and a 1.25 mm-wide internal circumferential spring-clip
  groove retains it 5.25 mm in from that rear edge. The groove has a 0.5 mm
  radial recess, leaving 1.5 mm of sleeve wall.
- **Slider 2, LED post:** a 22.8 mm-wide flat plate, flush with the harness
  sides, with its pad on the beam axis and a cable pass-through below the star
  footprint. The 20 mm star retains 1.4 mm of support per side.

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
brighter**. Travel toward zero gap is worth more than travel past 25 mm. V1 is
limited to short-duration operation. The passive vents reduce trapped heat but
do not replace a heatsink for continuous use.

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
| Rail sliding fit | 0.3 mm total lateral, 0 mm vertical | Physical prints showed excessive play at 1.0 mm total. The tighter 0.15 mm-per-side slip fit reduces rocking; direct top seating prevents optical-axis drop before clamping. |
| Harness side depth | 9 mm slot depth around 9 mm rail, 0 mm floor clearance | Seats the side runners on the bottom-U floor while the slot roof seats on the rail top. |
| Beamsplitter fit | 2.4 mm printed slot for measured 2.5 mm plate | The intentional 0.1 mm interference is removed by light filing until the plate seats securely. |
| Lens retention | Purchased tube, spring clip, 1 mm lip, 1.25 mm-wide internal groove | The lip fixes the cube-facing end. The rear groove gives the clip a positive seat while retaining the tube-in-tube fit. |
| Sleeve wall | 2 mm | Path B frees the interior size, so the earlier 1 mm workaround is unnecessary and would print weak. |
| Focus adjustment | Two independently clamped sliders | Both LED and lens positions must be tuned empirically. |
| Thermal design | Baffled passive vents, no heatsink in v1 | Short-duration operation limits heat input. Low side intake and high roof exhaust reduce trapped heat, but continuous use still requires a measured thermal solution. |
| Slider print faces | Full-depth sleeve harness; offset LED feature | Coplanar end faces let both sliders print on their backs without supports. The full-depth sleeve foot also centers its modeled mass over the rail contact while preserving the optical plane. |
| Harness wall | 6 mm | A 5 mm heat-set insert cannot live in a 3 mm wall. Enforced by assert. |
| Harness insert shoulder | Retained | The insert pocket needs a depth stop; the smaller continuation gives the clamp screw access to the rail. |
| Cell-to-cube interface | Standard uFace plus 44.2 mm bridge | The uFace enters the standard cube slot, while the bridge overlaps the cell wall and face so they slice as one connected part. |
| Post mount face | The side face opposite the illumination cell | The cell hangs its whole mass off one cube face. Mounting opposite turns that into a pitch moment in the plane of the gusset, which the tall backplate and the vertically separated M5 bolts resist directly. A 90 degree mount would turn the same load into roll about the post, which shows up as image rotation. |
| Post standoff | 72 mm from the post mating face to the cube center | The backlight short side measures 149.9 mm, so half of it is 74.95 mm. 72 mm puts the cube center just inside the backlight center and still leaves 30 mm of gusset between the uFace and the backplate. |
| Post interface | Three-sided socket, 0.2 mm total width clearance, 4 mm walls, 14 mm deep | The broad flanks set the pose against the extrusion so the two M5 bolts only supply clamp force, not alignment. The 0.2 mm is a starting guess and is what the socket coupon exists to check. |
| M5 hole position | Round 5.5 mm holes at Y +/-43 | The T-nut sits in the post slot on the cube centerline, so each bolt head faces the cube. Both holes have to sit far enough out along Y that a bolt head plus a washer clears the 73 mm cube envelope. That, not the plate, is what sets the 105 mm backplate height. |
| Round holes, not slots | Plain through-holes rather than the reference bracket's pill slots | The T-nut already slides freely along the post slot, so the bracket sets its own height by where it is clamped. Slots would only add material and a stress riser at the most heavily loaded part of the plate to buy travel that is already available. |
| M5 head approach | 3 mm straight pocket, then a bell flaring to a 24 mm mouth. Its rise is DERIVED, currently 16.45 mm | The bolt head faces the cube, so a hex key has to come back out through the gusset. The flare edge does not recede inboard of a 9 mm driver until Z=-25.55, so the bell has to reach past that or a shelf of gusset caps it. A typed-in 9 mm rise left exactly that shelf, 2.7 mm thick, and no key could reach the bolt. The rise is now computed from the flare rate and asserted. |
| M5 driver clearance | 9 mm straight run on the bolt axis, verified by swept-cylinder intersection | Both fastener sets are checked by sweeping a driver cylinder along its access axis and intersecting it with the bracket plus the 73 mm cube envelope. M3 measures clear to 6.0 mm and M5 to 9 mm. The M5 figure is held two full mm under the 11 mm funnel throat: the throat is a 72-sided polygon, so a nominally equal driver binds on facets. |
| M5 funnel throat | 11 mm, sized for a washer and not just the head | A bare M5 socket cap bears on 33 mm^2, which is 30 MPa at 1 kN of preload. A DIN 125 washer takes that to 55 mm^2 and 18 MPa. PLA creeps well below yield under permanent load, so that margin is the difference between a joint that holds and one that needs re-torquing. The washer OD is 10.0 mm, but the throat is a 72-gon, so a nominal 10 measures 9.99 across the flats and would not pass it. 11 is the next step up. |
| Print settings | The shared 0.4 mm profile as-is, 15 percent grid and 3 perimeters, plus one manual solid modifier around the two M5 seats. Sliced that way it is 69 g and 6h47m, of which about a seventh of the filament is buildplate-only support under the plate ledge | Infill is not the strength lever here. The gusset root has a section modulus of about 49,900 mm^3, so the 5 N cell load at a 72 mm arm works the root to 0.003 MPa, which is 0.01 percent of PLA interlayer strength, and models a 0.00007 mm tip deflection. Raising infill to 20 percent gyroid and adding a fourth perimeter was measured at 82 g and 8h40m, so it spends 13 g and two hours on a section that is already 4 orders of magnitude oversized. What actually governs is local bearing and creep where the bolts clamp, which is why those seats get solid material and a washer instead. `led_post_slider` is a 3.8 g part with nothing structural in it, so raise its infill only to give the clamp-screw heat-set insert bite in the 6 mm harness wall. Its real limit is heat, since v1 has no secondary heatsink and PLA softens near 60 C. |
| M3 screw pitch | 26.0 mm, derived from the vendor formula `0.5*(faceSize - d)` | Deriving it from `face_outline_mm` instead put every passage 0.4 mm per axis, 0.57 mm radially, off the real hole. That is enough to shave an M3 clearance passage below the 3 mm shank. The same expression was wrong in `cell_mating_screw_passages()` and is now corrected there too. |
| M3 cap reliefs | 6.0 mm bores, depth DERIVED, currently 13.2 mm | The gusset buries the four vendor counterbores, so each needs a corridor bored through it. 6.0 mm matches the vendor counterbore exactly (`capR = 3`) and is the widest bore that does not breach the 0.1 mm of plate rim left at the corner. The depth is computed from where the flare edge pulls inboard of the bore, the same rule as the M5 bell, instead of the magic 20 mm it used to be. |
| Gusset weld band | The 0.5 mm root overlap is clipped to vendor plate material and inset 0.1 mm inside the plate outline | The gusset root is a plain square slab. Unioned raw, it silently re-filled the voids the vendor plate cuts for itself: the four mid-edge notches that clear the cube's retaining tabs, and the four cap counterbores. Both defects render as valid watertight manifolds, so `Simple: yes` never caught them. Clipping the band to vendor material means the overlap can only add where the plate is already solid. The 0.1 mm inset is separate: the gusset is already flaring in Y by the time it reaches this band, so flush with the plate outline would put 0.37 mm out into the cube's 0.4 mm face gap. With the inset, the boolean against the cube measures exactly empty. |
| Weld band written as one difference | Not as two stacked solids meeting at the plate plane | The stacked form duplicated a face across the whole gusset cross-section. CGAL and the exported STL were fine, but OpenCSG preview z-fights on duplicated faces and drops surrounding surfaces out of the picture, which reads as clipping through the part. |
| Post mount print orientation | uFace flat on the bed, gusset growing upward | Layer lines then run across the bending stress rather than along it, and the flaring gusset is its own printing support for the backplate that overhangs it. The flare is asserted to stay inside 45 degrees; it currently runs at 37.95 degrees over a 30 mm rise. |
| No coved root fillets | The flare is the cove | The reference bracket's cove fills the inside corner of an L. Here the uFace and the backplate are parallel and 30 mm apart, so there is no corner to fill. A concave arc between the same endpoints, held inside the overhang budget, only scoops about 1.4 mm out of a 30 mm run, which is below what the printer resolves. |
| Gusset lightening | Three 14 mm round windows on the neutral axis, 17 mm pitch | Bending stiffness comes from material out at the flare, so the material near Y=0 is nearly free to remove. The windows are bored along X, so printed uFace down their axes lie in the build plane and each bridges its own crown. Only the centre window actually sits on the neutral axis; the outer two trade a little stiffness for a lot of mass. |
| Which cube face | Any of the four side faces | The light axis must be horizontal so the sliders sit on a floor. The cube is 4-fold symmetric, so the printed part is identical whichever side is chosen. Picked at assembly time, not design time. |

## 5. Dependencies and repository state

| Library or tool | Purpose | Location |
| --- | --- | --- |
| OpenSCAD | Parametric CAD, preview, STL | `C:/Program Files/OpenSCAD`; validate with hard warnings. |
| PrusaSlicer | Ender 3 V2 toolpath smoke tests | Resolved 0.4, 0.2, and 0.1 mm nozzle profiles under `slicer/`. |
| Official uCube library | Cube shells and uFaces | `vendor/uCube`; fixes documented in `PATCHES.md`. |
| BOSL2 | M37 thread geometry | Pinned under `vendor/BOSL2`. |
| GitHub | Source and exports | `Slaps404/microcube-optical-setup`, branch `main`. |

## 6. Open questions and known risks

- **An initial cell and slider prototype has been printed.** Its measured
  printed rail and harness were approximately 10.4 mm and 11 mm, or about
  0.6 mm total play. The modeled fit is now nominally 0 mm total clearance;
  this still needs a physical coupon because OpenSCAD validity does not prove
  printer tolerance.
- **Sleeve depth 25 mm is confirmed against the purchased tube.**
- **Spring-clip groove fit is unprinted:** the current groove is 1.25 mm wide,
  5.25 mm axially in from the open rear, and recessed 0.5 mm radially. Test
  the actual spring clip and tube together before committing to the full print.
- **M3 insert fit is unprinted:** the current cell harness pocket is 4.0 mm
  diameter by 5.0 mm deep, followed by a 3.2 mm screw passage. The passage
  center is 3.6 mm below the rail top, leaving 2.0 mm of rail-top clearance
  above the passage and 1.6 mm above the insert pocket. This leaves a 0.4 mm
  radial shoulder and 1 mm axial backing wall. The complete fit still needs a
  printer/material coupon with the purchased insert.
- **Seam clearances are untested.** The 0.25 mm lid slip fit and the
  tongue-and-groove both need a printed coupon.
- **Light-tightness is unproven.** The vent louvers and intake shroud block the
  direct perpendicular path, but oblique leakage through the vents and leakage
  at the removable lid seam still require a dark-room test. Plan on 3
  perimeters or a matte black interior.
- **Passive cooling is unproven.** The vents are appropriate only for the
  planned short-duration LED operation. Measure LED-board and enclosure
  temperature before increasing duty cycle; vents are not a heatsink.
- **The LED post is a thin tall cantilever.** It carries only a 2 g board, but
  check stiffness and print quality on the first article.
- **Optical data is provisional:** clear aperture, EFL 40 mm, and BFL 26 mm are
  not confirmed measurements.
- **The cell bottom sits 0.5 mm below the cube bottom**, since the floor wall is
  4 mm where 3.5 mm would be flush. Cosmetic on a benchtop.
- **Cable path needs physical definition** beyond the pass-through notch.
- **External frame mounting is dimensioned but unprinted.** `post_mount` is a
  blank side uFace that flares into a 28.2 x 105 x 6 mm backplate with a
  three-sided socket for the post. It replaces the lab clamp that loaded the
  whole optical head through the lens barrel. The camera still needs its own
  support on a separate horizontal extrusion above the cube; that is not
  designed. Open items on this part:
  - The post is confirmed as standard 20 x 20 mm T-slot extrusion with one
    centered slot per face, but the **slot opening width and T-nut thread are
    still unconfirmed**. The design assumes M5 T-nuts.
  - The 0.2 mm total socket clearance is a guess. Print
    `post_mount_socket_coupon.stl` first.
  - The socket walls now wrap 18 mm of the 20 mm post section while retaining
    the 0.2 mm total width clearance.
  - **The part is large.** 121 cm^3 of enclosed volume, 58.2 x 105 x 60.5 mm,
    which is a long print. If print time turns out to be unacceptable, the next
    step is replacing the solid gusset with three flaring ribs, which models to
    roughly 90 cm^3 but adds bridging under the backplate.
  - **PLA creep is a real risk here.** The bracket is permanently loaded in
    bending by the cantilevered illumination cell. Prefer PETG, or plan to
    re-check alignment over time.
  - The earlier one-tab C-frame concept is rejected as too flexible; see
    `research/optical-head-frame-integration.md`.
- **The complete-assembly preview has the camera on a side face, which does not
  match the physical downward-looking setup.** The printable M37 face itself is
  orientation-neutral. Correct the preview transform in a separate geometry
  task after the external frame concept is selected.
- **Future illumination optics need a frame-supported expansion rail.** Preserve
  a horizontal rail datum through the center of the illumination uFace so a
  longer train, including field and aperture diaphragms for Köhler illumination,
  does not cantilever from the printed cube face.
- **Focus distances must be set empirically.** The ~2 cm LED-to-lens figure is a
  guess, not a measurement. Both sliders adjust, so nothing depends on it.
- The active Path B cell has individual export entry points for its bottom U,
  top U, lens slider, and LED slider. The older adjustable-collimator files in
  `exports/current` are historical and must not be mixed into this assembly.

## 7. Testing considerations

| What to test | Method | Success criteria | Phase |
| --- | --- | --- | --- |
| Face screws | Mount one custom uFace on the real cube | Counterbores face outward and cap screws seat fully | Fit coupon, do this first |
| Rail and harness | Print a short rail section and one foot | Foot rests on the floor and rail, slides by hand without binding, and clamps without rocking | Fit coupon |
| Sleeve bore | Print a shallow sleeve ring | The 40.0 mm tube inserts without force, minimal play | Fit coupon |
| Sleeve spring clip | Print a shallow sleeve ring with the rear groove | The spring clip seats fully, retains the tube against the 1 mm lip, and can be removed without damaging the tube | Fit coupon |
| M37 thread | Print `m37_thread_fit_coupon.stl` | Lens engages smoothly without splitting | Fit coupon |
| Lid seam | Print short sections of both U shells | Lid drops on and the seam has no objectionable light leak | Fit coupon |
| Beamsplitter slot | File the 2.4 mm slot for the measured 2.5 mm plate | Plate seats securely without edge stress; supports hidden in side view | Bench assembly |
| Light-tightness | Assemble, light the LED, darken the room | No visible leak at seams or through the walls | Bench assembly |
| Passive ventilation | Run the intended short-duration LED sequence and measure the LED board and enclosure | Temperatures remain within the purchased LED and material limits; stop if they continue rising | Bench assembly |
| Illumination | Sweep both sliders with the real LED | Even field on the cube face without imaging the emitter | Optical prototype |
| Post socket fit | Print `post_mount_socket_coupon.stl` and slide it onto the real extrusion | Socket seats flat on the post face with no rock, slides on by hand, and an M5 T-nut bolt pulls it tight without spreading the walls | Fit coupon, do this before the full bracket |
| Post mount bolt access | Offer the printed bracket up to the post with the cube attached | A hex key reaches both M5 heads without fouling the cube, and the bell lets the screw start off-axis. The CAD says clear to a 9 mm driver; confirm with the real key and the real cube | Bench assembly |
| Post mount stiffness | Mount the loaded head and check for sag and drift | No visible tilt, and alignment holds over the run; recheck after a week for creep | Bench assembly |
| Mesh validation | Hard warnings plus six-view inspection | Every printable mode reports `Simple: yes` | Every CAD revision |
| Slicer validation | Slice all ten active STLs with the assigned Ender 3 V2 profile | G-code is produced without slicer errors or bed-volume failures | Every CAD revision |

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
| 16 | Post mount |
| 17 | Post mount socket fit coupon |
| 18 | Condenser carrier |
| 19 | Collector carrier |
| 20 | LED carrier |
| 21 | Carrier foot fit coupon |

Modes 18-21 build with whichever foot `carrier_rail_kind` selects. The eight
entry files under `exports/current/` pin the foot per part instead, because a
file-scope assignment in `optical_setup.scad` cannot be overridden from an
including file.

## 9. Separate-optic carriers

The Koehler retrofit puts the collector and the condenser `f1 + f2 = 16 + 40 =
56 mm` apart at their principal planes. That does not fit one 25 mm sleeve or
one 40 mm lens tube, so the two optics move onto independent carriers that
slide to set focus. This supersedes the single `lens_sleeve_slider` for the
retrofit; the old slider is retained and unmodified.

Both supplied lenses are 40.0 mm diameter (spherical collector, aspheric
condenser), so one cell geometry serves both and only the stack length
differs. The cell deliberately reuses the legacy sleeve envelope: 41 mm bore,
45 mm OD, same spring-clip groove.

That reuse is the load-bearing decision. A printed threaded retaining ring
needs a thread major larger than the 41 mm bore, which pushes the cell OD past
50 mm, which pushes the rail datums 3 mm lower and breaks compatibility with
the existing printed cell. The supplied set already solves retention without
any of that: the lens seats on a 38 mm front lip, the supplied 40 OD / 38 ID /
13 mm divider ring sits behind it as a flat pressure washer, and the spring
clip loads the divider. The clip never touches glass, and the two annular
lands that clamp the lens have the same 38 mm ID, so the load is symmetric.

Two feet are provided for the same carriers, chosen by `carrier_rail_kind`:

- `0`, 2020 extrusion: an inverted U with a 20.2 mm straddle slot open
  downward, 5 mm side walls, and one M5 per side into a T-nut in the
  extrusion's side slot. The holes sit on the extrusion's vertical
  centerline, which is the height of the side T-slot. Round holes, not slots,
  for the same reason as `post_mount`: the T-nut already slides. Each hole is
  counterbored 2.5 mm at 11 mm on a 72-gon for a DIN 125 M5 washer, leaving a
  2.5 mm bearing wall. Inside corners of the slot are relieved 1.6 mm for the
  extrusion's corner radii; unlike `post_mount`'s reliefs these run along X,
  because here the slot runs along the light axis rather than across it.
- `1`, printed rail: the legacy `harness_foot` reused unchanged. Its rail
  datums derive from `sleeve_outer_mm`, and the carrier cell keeps that same
  45 mm OD, so it drops onto the existing rail section with no new rail
  parameters. Only its length along X changes, from 25 mm to 16 mm, so more
  of the rail is focus travel.

Lens center thicknesses are PROVISIONAL (`collector_lens_thickness_mm = 14`,
`condenser_lens_thickness_mm = 18`) and set the cell lengths. Measure both
elements and correct these before printing a full carrier.
