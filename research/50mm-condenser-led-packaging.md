# 50 mm condenser, LED, driver, and heatsink packaging

Scope: mechanical packaging guidance for the existing official 40 mm uCube
light face. This does not change `optical_setup.scad`.

## Recommendation

Build this as an **external, removable light engine**, not as parts inside the
cube or the current 48 mm chamber:

```text
cube <- 30 mm aperture <- curved condenser face | condenser | plano face
     <- 25 mm adjustable air gap <- single LED on MCPCB
     <- thin thermal interface <- aluminum heatsink <- open air
                              driver in a separate side pocket
```

Use the current uFace only as the datum and attachment flange. Enlarge the
external pod to about 60 mm OD or 60 x 60 mm while keeping its centered output
aperture at 30 mm. A 60 mm pod remains inside the uCube's 68 mm overall square
envelope when centered, but it overlaps the 53.2 mm face and must be checked
against neighboring face screws.

## Why the current chamber cannot hold it

- Current CAD chamber: 48 mm outside, 42 mm inside, 14.1 mm deep.
- Cube opening: 40 mm. Official face outline in this project: 53.2 mm.
- A nominal 50 mm lens fits none of those openings.
- Even across the 53.2 mm face, a 50 mm lens leaves only 1.6 mm per side for a
  printed wall. That is not a robust retaining cell.
- The earlier 15 to 20 mm source standoff is incompatible with stock 50 mm
  aspheric condensers. The most compact current candidate below needs about
  41.4 mm from its output vertex to the LED plane, before the heatsink.

## Lens candidates and required spacing

| Lens | Published dimensions | Mechanical consequence |
|---|---|---|
| [Thorlabs ACL5040U-A](https://www.thorlabs.com/item/ACL5040U-A) | D 50.0 +0/-0.5 mm; clear aperture >45 mm; CT 21.0 +/-0.3 mm; ET 2.6 mm; EFL 40 mm; BFL 26 mm; NA 0.60; AR coating 350-700 nm | User-selected default. Start with the LED die about 26 mm behind the plano face. Approximate output-vertex-to-LED length is 47 mm. |
| [Edmund #36-171](https://www.edmundoptics.com/p/50mm-Dia-x-40mm-FL-Uncoated-Molded-Aspheric-Condenser-Lens/34734) | D 50.00 +0/-0.3 mm; clear aperture 44.78 mm; CT 21.42 +/-0.30 mm; ET 3.21 mm; EFL 40.00 mm; BFL 25.92 mm; NA 0.62 | Start with the LED die about 25.9 mm behind the plano face. Approximate output-vertex-to-LED length is 47.3 mm. |
| [Edmund #46-661](https://www.edmundoptics.com/p/50mm-diameter-x-357mm-fl-aspheric-condenser-lens/7005/) | D 50.00 +0/-0.3 mm; clear aperture 45 mm; CT 16.70 +/-0.25 mm; ET 2.0 +0/-0.3 mm; EFL 35.70 mm; BFL 24.7 mm; NA 0.64 | Shorter option. Start near 24.7 mm LED-to-plano spacing; approximate output-vertex-to-LED length is 41.4 mm. |
| [Edmund #22-686 smooth diffuse condenser](https://www.edmundoptics.com/p/517mm-dia-x-34mm-fl-uncoated-molded-condenser-lens-with-smooth-diffuser/48101/) | D 51.68 +/-0.20 mm; clear aperture 43.20 mm; CT 24.24 mm; BFL 18.10 mm; EFL 34 mm | Combines diffusion and condensation, but needs an even larger cell and still occupies about 42.3 mm before cooling hardware. |

These BFL positions are starting dimensions, not final focus settings. Provide
at least 4 to 6 mm of axial adjustment for the LED/heatsink carriage. Thorlabs
notes that real LED collimation is adjusted experimentally and that source size
and focal length set residual divergence: [official mounted-LED collimation guidance](https://www.thorlabs.com/newgrouppage9.cfm?objectgroup_id=2692&partnumber=MWWHLP2).

Place the lens's curved face toward the cube/output and its plano face toward
the LED, following the manufacturer's infinite-conjugate orientation. Do not
assume the full 50 mm becomes useful illumination: the cube opening clips it to
40 mm and the present 45-degree 50 mm beamsplitter limits a face-normal field
to about 35.4 mm. A 30 mm output mask remains appropriate.

## Lens retention

Use a two-part lens cell:

1. A fixed shoulder contacts only the lens edge annulus.
2. A removable threaded or three-screw retaining ring applies light axial
   preload through a thin silicone or EPDM O-ring.
3. The retainer must not touch the strongly curved optical surface.
4. Make the lens pocket replaceable so its measured diameter and edge thickness
   can be fit without reprinting the uFace.

For #36-171, the 50 mm physical diameter and 44.78 mm clear aperture leave a
nominal 2.61 mm radial edge annulus for retention. Thorlabs' analogous Ø2 inch
system uses retaining rings, including a rubber O-ring version for
stress-reduced mounting: [SM2 lens tubes and retaining rings](https://www.thorlabs.com/newgrouppage9.cfm?objectgroup_ID=3383).

## LED and thermal stack

A single small emitter is the cleanest first optical test. A representative
choice is Cree's XP-G4 or XP-G4 HI family. The package is 3.45 x 3.45 mm, the HI
version has a 1.4 x 1.4 mm light-emitting surface, and the family supports up to
3 A: [Cree XP-G4 datasheet](https://downloads.cree-led.com/files/ds/x/XLamp-XPG4.pdf) and
[XP-G4 HI product note](https://www.cree-led.com/news/xlamp-xpg4-hi/).

Start at 700 mA, not maximum drive. Mount the LED on a purchased or custom metal
core PCB whose exact outline is measured before CAD. Clamp that board to an
aluminum heatsink with a thin thermal interface material. The printed shell
locates parts but is not the heat path. Cree defines the required heat path as
LED junction -> PCB -> thermal interface -> heatsink -> ambient:
[Cree thermal-management guide](https://assets.cree-led.com/a/da/x/XLamp-Thermal-Management.pdf).

A 35 x 35 x 18 mm finned sink is a plausible starting envelope for the rear of
the pod, but it is not validated until the exact LED electrical power, ambient,
airflow, and allowable temperature are known. Keep fins exposed to room air.
Do not enclose them in the printed chamber. Add a fan only if a temperature test
shows passive cooling is inadequate; a fan also adds vibration and dust.

## Driver packaging and Raspberry Pi control

The [Mean Well LDD-700L official datasheet](https://www.meanwell.com/Upload/PDF/LDD-L/LDD-L-SPEC.PDF)
gives a compact reference driver:

- 22.6 x 9.9 x 8.9 mm;
- 9 to 36 VDC input;
- 700 mA constant-current output;
- PWM DIM supports remote ON/OFF at 100 Hz to 1 kHz;
- DIM high is specified above 3.5 V or open, and off below 0.5 V.

Put it in a ventilated side pocket beside the optical barrel, not between the
MCPCB and heatsink. Route five conductors through a strain-relieved notch:
power +/-, LED +/-, and DIM/control. Do not rely on a Raspberry Pi's 3.3 V GPIO
to meet the driver's specified 3.5 V high threshold. Use a small transistor or
logic interface that presents the driver's documented open/low DIM states and
defaults the light off during Pi boot. The interface circuit should be reviewed
before connection.

## Uniformity tradeoff

An aspheric condenser collimates a small emitter but does not by itself erase
the LED die image. A diffuser improves uniformity by turning the source into a
larger angular/spatial source, which increases divergence. Thorlabs explicitly
documents diffuser-surface condensers as more uniform and notes that coarser
diffusion lowers transmission: [official archived diffuse-condenser data](https://www.thorlabs.com/catalogpages/Obsolete/2015/ACL5040-DG6-A.PDF).

Therefore make the diffuser a removable coupon near the LED/plano side. Test
both configurations rather than permanently integrating it:

- single emitter, no diffuser: best collimation, possible die structure;
- single emitter plus diffuser: better spatial uniformity, wider beam and less
  output.

If both high uniformity and low divergence are required, one condenser plus one
diffuser is probably the wrong architecture. A two-condenser homogenizing stack
is longer and outside the present compact scope.

## Measurements required before CAD

1. Exact lens part number, measured diameter, center thickness, edge thickness,
   and which surface faces the source.
2. Exact LED wavelength/CCT/CRI, emitter or COB, MCPCB outline, hole pattern,
   thickness, and solder-pad clearance.
3. Continuous current, strobe duration, and capture duty cycle.
4. Required brightness and uniformity over the actual target plane.
5. Allowed total external depth. Expect about 60 to 70 mm including lens,
   focus travel, MCPCB, and an 18 mm passive heatsink.
6. Whether a 60 mm pod may overlap adjacent uCube faces and screw access.
7. Maximum acceptable heatsink and printed-part temperatures.

The lowest-risk next step is a parametric 60 mm external pod with three
separable parts: uFace adapter, lens barrel/retainer, and sliding
LED-heatsink carriage. Print only a lens-diameter fit ring first, then verify the
real lens and MCPCB before printing the full pod.

## Required CAD parameters

Do not derive the mechanical LED location from nominal focal length alone. A
thick asphere's back focal length and center thickness are separate catalog
values. The OpenSCAD model should expose at least:

- `condenser_diameter_mm = 50`;
- `condenser_clear_aperture_mm = 45`;
- `condenser_efl_mm = 40`;
- `condenser_bfl_mm = 26`;
- `condenser_center_thickness_mm = 21`;
- `condenser_edge_thickness_mm = 2.6`;
- lens-pocket clearance and edge-retainer overlap;
- LED die height, MCPCB dimensions, and focus adjustment travel;
- driver, heat-spreader, heatsink, and fan envelopes.
