# Compact uniform square light for the 50 mm beamsplitter cube

Research only. This note does not select or modify the final CAD design. The
remaining design questions must be resolved first.

## Provisional conclusion

Keep the light's output window nearly flush with the cube's inside face. Put
the LEDs, optical mixing volume, wiring, and aluminum heat path outside the
cube. This preserves the volume required by the 45-degree beamsplitter.

```text
outside cube                                      inside cube
[heat spreader | LEDs | mixing optics] -> [diffuser/output]  gap  / 45-degree plate
                                                        cube face |
```

There are two strong implementations:

1. **Best first prototype:** a direct-lit 6 x 6 or 7 x 7 wide-angle LED array,
   shallow reflective cavity, and replaceable diffuser. It is easy to build,
   measure, and tune.
2. **Best thin final cassette:** a patterned edge-lit light-guide plate with a
   rear reflector and top diffuser. Complete 50 mm commercial precedents are
   6 to 8.5 mm thick, but good uniformity requires a graded extraction pattern
   and a non-emitting mixing border near the LED rail.

An off-the-shelf backlight mounted outside a face is the fastest way to test
whether this illumination concept works before designing either cassette.

The first unresolved decision is more important than the LED choice: define
where the light must be uniform. A uniform glowing panel does not guarantee
uniform irradiance after the beamsplitter or in the final camera image.

## Focused 30 mm output result

This section assumes a 30 mm circular or square output and only 15 to 20 mm of
total optical depth outside the cube face.

**Result:** no verified stock design found here gives a full 30 mm square,
strong collimation, good spatial uniformity, and a 15 to 20 mm total depth.
The best first build is one shallow backlight with swappable front optics:

1. **Diffuse mode:** opal diffuser only. This prioritizes an even glowing face.
2. **Semi-collimated mode:** the same diffuser plus two crossed 3M brightness
   enhancement films. This narrows the output in both axes but is not true
   collimation.
3. **Optional directional coupon:** replace the diffuse source with a small LED
   and a compact TIR or Fresnel optic. This tests directionality, but it is a
   different source cartridge and will not produce the same uniform glowing
   face.

### Why one short lens cannot do both jobs

[Edmund Optics](https://www.edmundoptics.com/knowledge-center/application-notes/optics/considerations-in-collimation/)
states that ideal collimation requires an infinitesimal source at the lens
focus. Every point on an extended diffuser sends out a parallel bundle at a
different angle. Approximate full angular span is:

`full angle = 2 atan(source width / (2 focal length))`

For a 30 mm diffuser, the result is about 81 degrees with a 17.5 mm focal
length and 64 degrees with a 24 mm focal length. Reaching a 15-degree full
angle would require about 114 mm focal length, before lens thickness.
[Thorlabs](https://www.thorlabs.com/newgrouppage9.cfm?objectgroup_id=2692&partnumber=MWWHLP2)
also notes that LED size, focal length, and numerical aperture set the remaining
divergence.

This is the key distinction:

- A small LED die behind a 30 mm lens can make a roughly 30 mm directional beam.
- A 30 mm glowing diffuser cannot be turned into a narrow beam by one short
  lens.

[ams OSRAM's etendue guide](https://look.ams-osram.com/m/7b830a12bd3b7cfb/original/Projection-with-LED-light-sources.pdf)
explains the deeper limit: passive optics cannot reduce source area and angular
spread together without discarding light.

### Compact option comparison

| Option | What it actually solves | Depth result | Decision |
|---|---|---:|---|
| [3M crossed BEF prism films](https://multimedia.3m.com/mws/media/1389247O/application-guide-for-bef-family.pdf) | Compresses a diffuse backlight's angular output in both axes | About 0.31 mm for two 155 micrometer sheets, excluding supports | Best swappable semi-collimated prototype |
| [Opto Engineering CLLT film](https://www.opto-e.com/en/products/CLLT-series/CLLT3BC050050) | Published 15 +/-5-degree output from its matching backlight | 3.7 mm | Strong quantified precedent. Ask whether a 30 mm custom size is available |
| [LEDiL OLGA](https://www.ledil.com/news_all/product-news-olga/) | Collimates a small LED into a 10, 20, or 41-degree round beam | 30 mm diameter x 18.5 mm high | Fits depth narrowly. Directional cartridge only, not a uniform 30 mm square face |
| [Fresnel Technologies lens 0.3](https://www.fresneltech.com/hubfs/Spec%20Sheets/Fresnel%20Lens%20Brochure.pdf) | Thin point-source collimator | About 16.5 mm source-to-front | Fits, but active area is only 25 mm. Useful proof, not the final 30 mm output |
| 30 mm molded asphere | Better point-source collimation than a PCX lens | About 24 to 30 mm source-to-front for checked stock parts | Does not fit 20 mm and clear apertures are only 24 to 28 mm |
| Fly-eye or microlens system | Homogenizes a defined target plane | Normally needs two arrays plus a field lens | Stock 30 mm-class systems do not fit |
| Square light pipe | Mixes spatial nonuniformity, not angle | Stock examples are much longer than 20 mm | Reject for this envelope |
| Complete coaxial or telecentric light | Finished uniform directional illumination | Closest units checked are 33 to 125 mm deep | Reject as a component. Copy only the optical architecture |

Two geometry traps matter:

- A 30 mm diameter circular lens does not cover a 30 x 30 mm square. Covering
  the square corners requires at least a 42.4 mm circular clear aperture.
- A thin Fresnel sheet does not remove the source-size limit. It only reduces
  lens thickness.

### Recommended swappable prototype

```text
outside                                                     cube interior
[aluminum spreader | LED PCB | white 6-8 mm mixing cavity]
                  -> [opal diffuser] -> [swappable front film] -> 30 mm aperture

front D: no prism film                     diffuse, widest angle
front C1: one BEF sheet                    narrowed in one axis
front C2: two BEF sheets crossed 90 deg    narrowed in both axes
```

Start with a 5 x 5 wide-angle LED array near 6 mm pitch, a reflective cavity,
and a 30 x 30 mm output mask. Put the output nearly flush with the inner face.
This stays within the earlier direct-lit guidance while leaving the
beamsplitter volume clear. On 3M BEF, the prisms face away from the backlight.

Do not place a TIR or Fresnel optic after the diffuser and call the result
collimated. The directional test must replace the extended diffuser source with
a small LED near the optic's focus.

Before CAD, test fronts D, C1, and C2 without moving the source. Use fixed
camera exposure and measure both:

- spatial uniformity over the intended 30 mm region after the beamsplitter;
- beam growth on a screen at two distances, using
  `full angle = 2 atan((D2 - D1) / (2 distance change))`.

This experiment determines whether semi-collimation improves the real image
enough to justify its lost brightness and possible prism texture.

## Critical geometry from the current CAD

**Correction:** the earlier 52 mm interior interpretation is superseded. Direct
measurement of `exports/microcube-base.stl` and the official library default
`CubeSize(size=40, d=7)` establish the controlling envelope below.

- Clear internal span: 40 mm.
- Cube face: 54 mm.
- Overall cube envelope: 68 mm.
- Beamsplitter: 50 x 50 x 2.05 mm.
- Beamsplitter orientation: vertical and 45 degrees in plan view.

Engineering consequences:

- A 50 mm emitting area cannot pass through the 40 mm clear span. A complete
  50 mm-class light or its housing must remain outside the cube and illuminate
  through a smaller face aperture.
- A 50 mm plate at 45 degrees presents only this width to a face-normal,
  collimated beam:

  `W_projected = 50 cos(45 degrees) = 35.36 mm`

- A 30 mm face-normal field fits within that 35.36 mm projection with about
  2.68 mm nominal margin per side. If the plate has only 45 mm clear aperture,
  the projected width becomes 31.82 mm and the margin falls to 0.91 mm per
  side. The beamsplitter's actual clear aperture must be verified.

- A 50 mm-wide folded collimated field would require a plate about
  `50 / cos(45 degrees) = 70.71 mm` wide, before clear-aperture margins.
- The plate endpoints are only
  `40/2 - 25 cos(45 degrees) = 2.32 mm` from the adjacent inside faces. Keep the
  source output essentially flush. Even a small inward-projecting retainer can
  collide with the beamsplitter edge.
- A 61 x 61 mm external module is smaller than the 68 mm overall cube envelope
  but larger than the 54 mm face. It still needs an external holder or revised
  face attachment, not an assumed internal or flush fit.

The 35.36 mm result applies to face-normal rays. A diffuse source contains many
ray angles, but light outside the plate's projected aperture still cannot be
cleanly folded into the intended axis. The needed field must be clarified.

## "Perfectly even" needs a metric

No physical source is perfectly uniform. Specify all four items:

1. Measurement plane: emitting window, target/object, or raw camera image.
2. Region of interest, for example the central 32 x 32 mm.
3. Metric, for example peak deviation, coefficient of variation, or min/max.
4. Operating state: wavelength, brightness, warm-up time, continuous or strobe.

Useful definitions are:

- `peak deviation = max(abs(E - mean(E))) / mean(E)`
- `CV = standard deviation(E) / mean(E)`
- `min/max = E_min / E_max`

[Labsphere's uniform-source guide](https://labsphere.com/wp-content/uploads/2021/09/Integrating-Sphere-Uniform-Source-Applications.pdf)
emphasizes that radiance uniformity at the source and irradiance uniformity at
a target are different measurements, and that target distance and geometry
affect irradiance uniformity.

## Architecture comparison

| Architecture | Strength | Main problem here | Provisional use |
|---|---|---|---|
| Direct LED array + diffuser cavity | Cheapest and easiest to tune | Needs optical depth and thermal testing | Best first custom prototype, with the cavity outside |
| Patterned edge-lit guide | Thin, low power, even emitting plane | Good extraction pattern is difficult to DIY; needs a mixing border | Best thin final cassette or OEM route |
| Complete commercial backlight | Known performance and fast test | All 50 mm-class housings exceed the 40 mm interior | Mount outside a face for concept validation |
| Shallow integrating cavity | Broad, diffuse angular output | A 50 mm exit consumes too much cavity volume | Reject as the first cube design |
| Integrating sphere | Calibration-grade radiance uniformity | Far too large | Performance reference only |
| Koehler illumination | Can homogenize the object plane | Adds collector, stops, condenser, length, and alignment | Only if final target-plane tests demand it |
| Collimated/telecentric backlight | Directional rays for measurement | Larger and more expensive; may be the wrong contrast | Only for metrology or directional imaging |

### Direct-lit design guidance

Two primary-source rules bracket the first experiment:

- [Nichia's 2025 direct-lit design note](https://led-ld.nichia.co.jp/api/data/spec/tech/SP-QR-C2-240141-E_Design%20Considerations%20for%20the%20Nichia%20NFSWL11A-D6%20LED.pdf)
  reports acceptable uniformity with wide-directivity LEDs at optical
  distance/LED pitch ratios around 0.7 to 0.8 in its tested construction. The
  test used reflective white solder mask and a 2 mm opal diffuser.
- [Luminit's hotspot application note](https://www.luminitco.com/sites/default/files/AppNote1_Hotspots_6_4_12_lo.pdf)
  gives the more conservative rule that diffuser distance should be at least
  the LED spacing. High-angle diffusers can help when this is not possible.

Inference for a first coupon, not a final design: a 6 x 6 or 7 x 7 array over a
roughly 42 to 48 mm square gives 7 to 8 mm pitch. Start with 6 to 8 mm of mixing
depth outside the face and test multiple diffusers. This stays near both source
rules without consuming beamsplitter space.

[Luminit](https://www.luminitco.com/sites/default/files/2022-07/Luminit_MachineVison_Tech-Data_0722_web.pdf)
publishes 85% to 92% transmission for its light-shaping diffuser family, so
greater hiding power trades away some brightness.

### Edge-lit design guidance

[ams OSRAM's light-guide design note](https://look.ams-osram.com/m/1c69505c886141ed/original/Light-guides.pdf)
shows that a uniform edge-lit guide needs:

- a non-active mixing range beside the LEDs;
- graded extraction dots or roughness, not an unmodified clear acrylic sheet;
- a rear reflector; and
- usually a top diffuser.

Therefore, a plain laser-cut acrylic square plus an LED strip should not be
assumed uniform. The LED rail and mixing border should live in the external
face flange, leaving only the selected output aperture near the 40 mm opening.

### Why a true integrating sphere is not compact enough

[Labsphere's integrating-sphere theory guide](https://www.labsphere.com/wp-content/uploads/2021/09/Integrating-Sphere-Theory-and-Applications.pdf)
recommends keeping total port area to a small fraction of sphere area. Using a
5% port fraction as a sizing check, a 50 x 50 mm port alone implies a sphere
diameter of about `sqrt(2500/(0.05 pi)) = 126 mm`, before other ports. That does
not fit either the 40 mm interior or the 68 mm overall cube envelope.

For a shallow reflective cavity, a high-diffuse-reflectance lining is more
appropriate than printed plastic alone. Furukawa reports [MCPET total
reflectance above 99% and diffuse reflectance above 96%](https://www.furukawaelectric.com/en/platform/brightening-mcpet.html).
This is a material reference, not a claim that a shallow cavity becomes an
integrating sphere.

## Beamsplitter consequences

- [Edmund Optics](https://www.edmundoptics.com/knowledge-center/application-notes/optics/what-are-beamsplitters/)
  notes that plate beamsplitters are commonly designed for 45-degree incidence
  and can add transmitted-beam shift, rear-surface ghost reflections,
  wavelength dependence, and polarization dependence. The exact plate and
  coating orientation therefore matter.
- For a path that reflects once and transmits once through an ideal 50/50
  splitter, the upper-bound splitter efficiency is `R x T = 0.25`, before all
  other losses. [CCS's coaxial-light architecture](https://www.ccs-grp.com/products/series/245)
  is a relevant commercial precedent for this double interaction.
- Using Snell's law with an assumed refractive index of 1.5, the 2.05 mm plate
  gives about 0.68 mm transmitted-ray lateral shift at 45 degrees. This is an
  inference until the actual glass index is known.

## Thermal constraint

The printed face should locate optics, not serve as the primary LED heat sink.
[Cree LED's thermal guide](https://assets.cree-led.com/a/da/x/XLamp-Thermal-Management.pdf)
describes the heat path from LED junction through PCB and thermal interface to
a heat sink and ambient. Put a metal-core PCB or aluminum spreader outside the
cube, then verify case and printed-part temperatures at steady state.

## Compact comparison

`Not stated` means the manufacturer does not publish that value in the cited page or datasheet. Inferences are labeled.

| Reference | Emitting area | Complete size | Published uniformity | Working distance | Electrical / heat | Availability / customization | Fit assessment |
|---|---:|---:|---:|---|---|---|---|
| [PHLOX LEDW-BL-50x50-LLUB](https://www.phlox-gc.com/datasheet/PHLOX_LEDW_BL_50x50_LLUB_Q_1R_24V.pdf) | 50 x 50 mm | 90 x 85 x 8.5 mm | >=95% (manufacturer notation also says +/-10%) | Not stated, specified at emitting surface | 24 V, <=260 mA, inferred <=6.24 W; housing may reach 80 C and must not be covered | Standard 50 mm size; PHLOX also advertises custom sizes up to 500 mm | Excellent uniformity/thickness reference, too large as a complete insert |
| [CCS LFL-50SW2-IU](https://www.ccs-grp.com/products/model/3151) | 50 x 50 mm | 72 x 72 x 6 mm | Numeric value not stated; series publishes a representative plot | Not stated, flat emitting surface | 24 V, 3.6 W max, natural cooling | Standard/on sale; CCS invites custom inquiries for the LFL series | Thinnest complete standard module found, but 20 mm too wide for cube interior |
| [TPL Vision SBACKII050502](https://www.tpl-vision.com/documents/techsheets/TPL_SBACK_II_TechSheet_FR.pdf) | 51 x 51 mm | 61 x 61 x 20 mm | [>90% surface uniformity](https://www.tpl-vision.com/overview/accessories/mounting-devices/tpl-mount-sback-square1/) | Not stated; 52 klux measured on diffuser surface | 24 V, 3 W max, aluminum body | Standard configured product, CAD available | Best compact complete module. Smaller than the 68 mm overall envelope, but larger than the 54 mm face and 40 mm clearance. Mount externally behind a face aperture |
| [TPL Vision CSBACK 50 x 50](https://www.tpl-vision.com/documents/technotes/TPL_Collimated_Lightings_Tech_Note_EN.pdf) | 50 x 50 mm nominal minimum | Outer length/width not stated; 21 mm thick | 90% surface homogeneity, qualified for telecentric viewing | Not stated | 24 V; power not stated | Configurable from 50 to 200 mm in 50 mm steps | Useful if directional output matters; ordinary diffuse backlight is likely simpler unless the imaging path needs collimation |
| [Opto Engineering LT3BC050050-W](https://www.opto-e.com/en/products/LT3BC-series/LT3BC050050-W) | 50 x 50 mm | 58 x 76 x 24 mm | Called excellent; numeric value not stated, individual measured test report advertised | Emitting-surface specification | 24 V, 140 mA, 3.4 W continuous; 6.7 W boost | Standard current product, optional collimation/polarization; manufacturer says contact for customization | Narrow dimension is close, but 76 mm length prevents internal fit. Good low-power optical benchmark |
| [Advanced Illumination BX2-00500050](https://www.advancedillumination.com/wp-content/uploads/2024/11/BX2_Series_Datasheet.pdf) | Ordering size 50 x 50 mm; drawing implies actual window 48.5 x 48.5 mm | Inferred from drawing: about 105.9 x 105.9 x 19.0 mm | +/-10% for emitting lengths below 200 mm | Uniformity measured at emitting surface | 24 V; white voltage-drive configuration is 0.30 A for 50 mm illuminated length, inferred 7.2 W | Built to order, typical 1 to 2 week shipment; 25 mm increments; semi/full custom advertised | Strong documented optical benchmark, far too large mechanically |
| [Metaphase TXBL/TXCBL](https://www.metaphase-tech.com/tx-backlight/) | 50 x 50 mm minimum | 10 mm bezel, other dimensions in downloadable drawing; exact 50 mm overall size not extracted | Not stated | Not stated | 24 V controller ecosystem; power not stated | Current configurable family; quick-ship options by inquiry; white/R/G/B/RGB/RGBW/IR, polarizer and collimated versions | Broadly configurable reference, but 10 mm bezel implies roughly 70 x 70 mm overall, an inference |
| [CCS LFV3-50 coaxial light](https://www.ccs-grp.com/products/model/4299) | Internal light-emitting surface 52 x 52 mm | 60 x 94 x 58 mm | Numeric value not stated; optional darker diffuser is documented to increase uniformity | Manufacturer example uses 57 mm LWD and 63 x 47 mm FOV in the [LFV3 note](https://www.ccs-grp.com/ecsuites/media/download/pamphlet/FL_LFV3_e.pdf) | 24 V; 11 W max for white | Standard family plus custom 90-degree port version | Best architecture precedent because it integrates square source, diffuser, and 45-degree half-mirror. Too large to reuse directly |
| [Fusion Optix custom MicroTEK light guide](https://www.fusionoptix.com/solutions/dna/lcd-backlighting/) | Custom; no 50 mm standard listed | Standard guide thicknesses 0.5, 1, 2, 4, 6 mm; LED rail and films add size | >90% 9-point uniformity standard; up to 90% optical efficiency | Not stated, output is the guide surface | Depends on custom LED rail/driver | Explicit system-level customization; components or complete backlight unit | Best OEM path for a custom 30 mm output through the 40 mm opening because guide, extraction pattern, LED rail, and films can be tailored together |
| [Labsphere MiniStar MS12-25BB](https://www.labsphere.com/product/ministar-uniform-illuminator/) | 12 mm circular exit | 25 mm square footprint; depth not stated | Qualitatively uniform, numeric value not stated | Not stated | Not stated | Current product; additional spectral variants prioritized by demand | Integrating-cavity precedent only. Its aperture is much too small, and scaling an integrating cavity to 50 mm would consume cube volume |

PHLOX's datasheet combines `>=95%` and `+/-10%` without publishing the exact
calculation. Treat it as a vendor benchmark until a measurement map and metric
are reviewed. The same caution applies to any unlabeled "uniformity" number.

## Best examples to copy

### 1. Nichia direct-lit test construction

Nichia's test setup combines wide-angle LEDs, reflective white solder mask,
and a 2 mm opal diffuser, then maps uniformity against LED pitch and optical
distance. Copy the experimental method, not its exact LED count. Source:
[Nichia design note](https://led-ld.nichia.co.jp/api/data/spec/tech/SP-QR-C2-240141-E_Design%20Considerations%20for%20the%20Nichia%20NFSWL11A-D6%20LED.pdf).

### 2. CCS LFL edge-lit construction

CCS places LEDs around a square light-guiding diffusion plate. Its special extraction pattern produces a flat diffuse source, and the 50 mm model is only 6 mm thick. This is the closest physical architecture to copy into a custom face cassette. Source: [CCS LFL series](https://www.ccs-grp.com/products/series/14).

### 3. PHLOX 50 mm performance target

PHLOX publishes >=95% uniformity and >=100,000 cd/m2 continuous luminance for a 50 x 50 mm, 8.5 mm-thick edge-lit source. The complete housing is too large, but it is a useful high-end benchmark. Source: [PHLOX datasheet](https://www.phlox-gc.com/datasheet/PHLOX_LEDW_BL_50x50_LLUB_Q_1R_24V.pdf).

### 4. TPL SBACK II external cartridge

At 61 x 61 x 20 mm with a 51 x 51 mm useful surface, this is the most plausible off-the-shelf module to mount behind a custom cube face. It also has the lowest published power among the complete 50 mm-class sources here at 3 W. Source: [TPL datasheet](https://www.tpl-vision.com/documents/techsheets/TPL_SBACK_II_TechSheet_FR.pdf).

### 5. CCS LFV3 integrated beamsplitter layout

The LFV3 is a direct precedent for placing a square LED/diffuser source next to a 45-degree half-mirror. It proves the architecture, while also showing why a 50 mm field is mechanically tight: its commercial housing is 60 x 94 x 58 mm. Source: [CCS LFV3 product](https://www.ccs-grp.com/products/model/4299) and [application pamphlet](https://www.ccs-grp.com/ecsuites/media/download/pamphlet/FL_LFV3_e.pdf).

### 6. Fusion Optix custom thin guide stack

Fusion Optix publishes >90% nine-point uniformity and lists 0.5 to 6 mm guide thicknesses, plus matching LED rails and optical films. This is the best documented custom/OEM route when the 40 mm clear span is non-negotiable. Source: [Fusion Optix LCD backlighting](https://www.fusionoptix.com/solutions/dna/lcd-backlighting/).

## Missing context that changes the choice

- Is this illumination for a camera, a viewer's eye, or a projected pattern?
- Required spectrum: white CCT/CRI, monochrome wavelength, IR, or RGB?
- Required brightness at the target or camera exposure, and continuous versus strobed operation?
- Maximum allowed source thickness outside the cube face?
- Must the output optic fit through the 40 mm opening, or may the complete
  housing sit outside the 54 mm face and within or beyond the 68 mm envelope?
- Required useful illuminated square: full 50 x 50 mm, or a smaller central field?
- Required uniformity definition and threshold, for example min/max over 9 points or +/- variation?
- Desired angular output: diffuse Lambertian-like, semi-collimated, or telecentric-compatible?
- Beamsplitter coating ratio and wavelength range, which determine how much light is lost and whether polarization matters?
- Heat limit near the printed material and whether an aluminum heat spreader is acceptable?
