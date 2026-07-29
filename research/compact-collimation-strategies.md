# Compact 30 mm illumination and collimation research

Scope: primary-source research for a circular or square 30 mm output with only
15 to 20 mm optical depth outside the cube face. No CAD was changed.

Geometry correction: the earlier 52 mm interior interpretation is superseded
by measurement of `exports/microcube-base.stl` and the official library default
`CubeSize(size=40, d=7)`. The controlling dimensions are a 40 mm clear span,
54 mm face, and 68 mm overall envelope. The 30 mm output still fits the nominal
35.36 mm face-normal projection of the 50 mm beamsplitter, but the plate ends
are only `20 - 25 cos(45 degrees) = 2.32 mm` from adjacent inside faces.
Therefore, keep the output flush and all housing depth outside.

## Bottom line

**Fact:** No stock glass condenser, stock fly-eye homogenizer, light pipe, or
complete coaxial light found here provides a full 30 mm output and fits in 20 mm.

**Inference:** The practical first prototype is one shallow backlight engine
with a common 30 x 30 mm output frame and two swappable cartridges:

1. opal diffuser only, for maximum spatial uniformity and wide-angle output;
2. the same diffuser plus crossed prism/collimating film, for approximately
   15-degree-class semi-collimated output.

If true low-divergence collimation is required, the hidden choice is either
reduce the useful aperture to about 25 mm, or permit more than 20 mm depth.

## The physics that sets the limit

### Tiny source and extended source are different

**Fact:** A small LED or point source placed at a positive lens's focal plane
produces an approximately collimated beam. Every point of an extended source
produces its own parallel bundle at a different angle. Thorlabs gives the
approximate full divergence as `theta ~= source size / focal length`; Edmund
states that ideal collimation requires an infinitesimal source and that a larger
source or shorter focal length increases divergence.

- [Thorlabs LED collimation geometry and formula](https://www.thorlabs.com/newgrouppage9.cfm?objectgroup_id=2692&partnumber=MWWHLP2)
- [Edmund Optics, Considerations in Collimation](https://www.edmundoptics.com/knowledge-center/application-notes/optics/considerations-in-collimation/)

**Inference:** For a 30 mm-wide diffuse source and a 17.5 mm focal-length lens,
the exact geometric field span is approximately
`2 atan(15 / 17.5) = 81.2 degrees`. With a 24 mm focal length it is still 64.0
degrees. To hold a 30 mm extended source to a 15-degree full angle would need
about `f = 30 / (2 tan(7.5 degrees)) = 114 mm`, before lens thickness.

This does not mean a 30 mm beam is impossible. A **small** source behind a
30 mm-aperture lens can form a 30 mm beam. A **30 mm glowing diffuser** cannot be
turned into a narrow 30 mm beam by one short lens.

### Etendue: spatial uniformity and angular narrowness trade against flux

**Fact:** OSRAM defines etendue from emitting area and angular extent and states
that source etendue cannot be reduced without loss. Passive optics therefore
cannot preserve all flux while keeping both the same large output area and a
much smaller output angle.

- [ams OSRAM, Projection with LED Light Sources, pp. 4-5](https://look.ams-osram.com/m/7b830a12bd3b7cfb/original/Projection-with-LED-light-sources.pdf)

**Inference:** A 30 x 30 mm Lambertian-like window has area 900 mm2. Restricting
the same area to a +/-7.5-degree cone accepts only `sin^2(7.5 degrees) = 1.7%`
of an ideal Lambertian flux on a single pass. Prism-film backlights improve
useful efficiency by reflecting rejected angles back for recycling, but they do
not remove the etendue constraint.

### Circle versus square

**Inference:** A 30 mm diameter lens cannot fill a 30 x 30 mm square. Covering
the square's corners requires at least a 42.4 mm circular clear aperture. A
30 mm circular clear aperture encloses only a 21.2 mm square. A square Fresnel
lens or optical-film stack is mechanically better for a square output.

## Option evidence

### 1. Aspheric or plano-convex condenser

**Required geometry:** place a small emitter at the rear focal plane. Put the
aspheric/curved face toward the collimated side and the flatter face toward the
source, subject to the specific lens prescription. An aperture mask sets a
square outline but discards the lens corners.

| Primary-source example | Published specification and current availability | 20 mm assessment |
|---|---|---|
| [Edmund #88-291 molded aspheric](https://www.edmundoptics.com/p/30mm-dia-x-175mm-fl-uncoated-molded-aspheric-condenser-lens/30549/) | 30 mm diameter, only 24 mm clear aperture, EFL 17.5 mm, BFL 10.4 mm, center thickness 14.0 mm, NA 0.86; page says Contact Us, $51 | Focal point to far lens surface is about 24.4 mm (`BFL + CT`), so it misses the limit and does not provide 30 mm clear output |
| [Edmund #36-169 molded aspheric](https://www.edmundoptics.com/p/30mm-dia-x-24mm-fl-uncoated-molded-aspheric-condenser-lens/34732/) | 30 mm diameter, 26.78 mm clear, EFL 24 mm, BFL 14.73 mm, CT 14.1 mm, NA 0.62; 20+ in stock, $27.75 | About 28.8 mm from focal point to far surface; does not fit |
| [Edmund #84-312 UV-fused-silica PCX](https://www.edmundoptics.com/p/30mm-dia-x-50mm-fl-vis-0deg-coated-uv-plano-convex-lens/27419/) | 30 mm diameter, 29 mm clear, EFL 50 mm, BFL 45.2 mm, CT 7 mm; 5 in stock | About 52.2 mm optical train; far outside limit |
| [Thorlabs AL3026-A](https://www.thorlabs.com/catalogpages/V21/745.PDF) | 30 mm diameter, 28 mm clear for collimation, EFL 26 mm, BFL 19.3 mm, CT 11 mm | About 30.3 mm; does not fit |

**Fact:** Aspheres reduce spherical aberration and allow much lower f-numbers
than ordinary PCX lenses. They do not eliminate divergence caused by finite
source size, and a single lens does not homogenize an LED die image.

**Inference:** A 30 mm-class asphere becomes plausible only if 25 to 30 mm total
depth is permitted and a 1 to 3 mm source/diffuser is used at its focus. At 1 mm
source size and 17.5 mm EFL, the approximate full divergence is 3.3 degrees.

### 2. Fresnel condenser

**Required geometry:** small source near the focal plane. Fresnel Technologies
specifies grooves toward the collimated beam and the plano side toward the
focus for its infinite-conjugate positive lenses.

| Primary-source example | Published specification | 20 mm assessment |
|---|---|---|
| [Fresnel Technologies catalog item 0.3](https://www.fresneltech.com/hubfs/Spec%20Sheets/Fresnel%20Lens%20Brochure.pdf) | EFL 15 mm, 25 mm active Fresnel area, 38 x 38 mm overall, 1.5 mm thick, 200 grooves/inch; catalog says availability can change | About 16.5 mm source-to-front depth, so it fits, but active output is only 25 mm |
| [Fresnel Technologies catalog item 1](https://www.fresneltech.com/hubfs/Spec%20Sheets/Fresnel%20Lens%20Brochure.pdf) | EFL 22 mm, 33 mm active area, 51 x 51 mm overall, 1.5 mm thick | About 23.5 mm; first stock-size example found that covers 30 mm, but too deep |

**Inference:** A custom 30 to 33 mm active Fresnel with EFL at most 18 mm could
fit, but it would be roughly f/0.55, demanding and sensitive to source position,
groove scatter, chromatic blur, and field angle. It is not a safe first design.

### 3. Brightness-enhancement, prism, and collimating films

**Required geometry:** uniform backlight, rear reflector/recycling cavity,
diffuser, then prism film with prisms toward the output. One prism sheet mainly
compresses one axis; two sheets crossed 90 degrees compress both axes.

| Primary-source example | Published specification and availability | Assessment |
|---|---|---|
| [3M BEF technical data](https://multimedia.3m.com/mws/media/1245088O/3m-brightness-enhancement-films-3m-bef-technical-data-sheet.pdf) | BEF3-T-155n is 155 +/-10 micrometers thick, 50 micrometer pitch, 90-degree prisms, effective transmission/gain 1.53; two sheets may be crossed | Easily fits. 3M does not publish a guaranteed output divergence in this sheet, so it is an experiment, not a specified collimator |
| [3M BEF application guide](https://multimedia.3m.com/mws/media/1389247O/application-guide-for-bef-family.pdf) | Says BEF narrows viewing angle, one sheet primarily in one plane, crossed sheets in both planes, prisms face away from the backlight | Best cheap swappable prototype film stack |
| [Opto Engineering CLLT3BC050050](https://www.opto-e.com/en/products/CLLT-series/CLLT3BC050050) | 3.7 mm thick, emission angle 15 +/-5 degrees, made for 50 x 50 mm LT3BC backlights; current quote-request product | Strongest quantified semi-collimating-film precedent. Ask Opto whether it may be cut to 30 mm or supplied custom; cutting is not manufacturer-approved on the page |
| [3M ALCF](https://www.3m.com/3M/en_US/industrial-manufacturing-us/applications/display-enhancement/) | Microlouver film, 48- or 60-degree viewing angle | Fits, but absorbs/blocks high angles instead of efficiently collimating. Too broad for a 15-degree target |

**Fact:** Luminit light-shaping diffusers spread an already collimated beam;
they do not collimate a diffuse source. Their standard circular range is 0.5 to
100 degrees FWHM and transmission is at least 90% for 0.5 to 20 degree types.

- [Luminit Light Shaping Diffuser specifications](https://luminitco.com/light-shaping-diffusers/)

**Inference:** Use a narrow Luminit sheet only after a collimator to smooth
structure or set a minimum beam angle. Do not put it before a lens and expect it
to create collimation.

### 3a. Compact TIR LED array optic

**Fact:** [Carclo 10610](https://www.carclo-optics.com/products/optic-10610)
is a 2 x 2 narrow-spot TIR optic with a 19.9 x 19.9 mm flange and 6.0 mm
height. Carclo publishes 14.5-degree FWHM and 90.5% optical efficiency with a
Nichia 757 LED configuration. The manufacturer offers sample requests.

**Inference:** This is the fastest shallow directional-light coupon, but it
produces four beams over only about 20 mm. A diffuser could hide the beam seams
at the cost of widening the angle. It does not satisfy a uniform 30 mm square
without a larger custom or tiled layout.

### 4. Fly-eye or microlens arrays

**Required geometry:** a first MLA splits the input into beamlets. A second MLA
near the first array's focal plane improves overlap. A downstream PCX/Fourier
lens superimposes beamlets at a target plane. This is a homogenizer, not a
single-sheet collimator.

| Primary-source example | Published specification and availability | 20 mm assessment |
|---|---|---|
| [Edmund #12-844 fly-eye array](https://www.edmundoptics.com/p/flys-eye-array-10-x-10mm-350microm-pitch-65deg-divergence/41536/) | 10 x 10 x 2.25 mm, EFL 1.59 mm, +/-6.5-degree divergence, 9 x 9 mm clear; 4 in stock, $915 | Compact but only 9 mm aperture, not a 30 mm solution |
| [Edmund paired-MLA design note](https://www.edmundoptics.com/media/4rdf0osq/prototyping-illumination-systems-with-stock-optical-components-en.pdf) | States square MLAs are often used in pairs with a PCX lens; example uses two 4.8 mm-EFL arrays and a 100 mm field lens | Full system cannot fit 20 mm |
| [INGENERIC Homogenizer Array-18.5](https://ingeneric.com/wp-content/uploads/2020/01/INGENERIC_MLA_2020-1.pdf) | 35 x 28 x 2 mm, EFL 18.5 mm, pitch 1.3 mm; manufacturer offers customization | One array nearly uses the whole depth before the second array and field lens |
| [Thorlabs FLE2 complete fly-eye homogenizer](https://www.thorlabs.com/thorproduct.cfm?partnumber=FLE2) | Working distance 95 mm; request lead time, $870.94 | Concrete evidence that a complete stock homogenizer is much longer |

**Inference:** A custom double-sided MLA could make a very compact flat-top
source, but it needs optical design and a defined target plane. It is not a
low-risk 30 mm DIY prototype.

### 5. Square light pipe or homogenizing rod

**Required geometry:** couple a high-NA source into a polished rod. Multiple
total-internal-reflection bounces mix position. A relay/condenser after the pipe
is still needed for collimation.

**Fact:** Edmund states that output uniformity increases with the number of
internal reflections, low-NA sources require longer pipes, and a tapered pipe
reduces divergence by the same factor as its area magnification. Its stock
examples scale from 2 mm aperture x 19-50 mm long to 10 mm aperture x 75-175 mm
long. A stock 2.5-to-5 mm tapered pipe is 50 mm long.

- [Edmund light-pipe overview](https://www.edmundoptics.com/knowledge-center/video/tutorials/light-pipe-overview/)
- [Edmund stock light-pipe family](https://www.edmundoptics.com/c/light-pipes-homogenizing-rods/697/)
- [Edmund 2.5-to-5 mm, 50 mm tapered example](https://www.edmundoptics.com/p/25mm-2x-50mm-length-standard-na-tapered-light-pipe/17717?PrintPDF=true)

**Inference:** A 30 mm-wide, 20 mm-long pipe has an aspect ratio of only 0.67
and allows too few sidewall bounces to homogenize a full aperture. It also does
not collimate by itself. This arrangement is not viable in the depth limit.

### 6. Commercial coaxial and collimated lights

| Primary-source example | Published specification and availability | Assessment |
|---|---|---|
| [Opto Engineering LT2QOG025-00-X-R-24V](https://www.opto-e.com/en/products/ltcxc-series/LT2QOG025-00-X-R-24V) | Coaxial light, 25.6 x 27 mm emitting area, 20-40 mm recommended working distance, 54 x 33 x 33 mm body, 3.6 W; current quote product | Closest commercial aperture, but 33 mm thick and only near 30 mm |
| [CCS LFV3-35SW-IU(A)](https://www.ccs-grp.com/products/model/3169) | Standard white coaxial light, 38 x 34 mm emitting surface, 46 x 75 x 40 mm body, 24 V | Far too large; duplicates the cube's beamsplitter architecture |
| [Metaphase BL1x1-CL](https://www.metaphase-tech.com/wp-content/uploads/2018/03/BL-CL_PDS-4-9-2018.pdf) | Collimated backlight, 23.6 x 23.6 mm active area, 69.9 x 69.9 x 23.6 mm housing, +/-5% uniformity; manufacturer offers custom sizes | Too thick and much too wide; no divergence number is published |
| [Opto Engineering LTCLHP024-G](https://www.opto-e.com/en/products/ltclhp-series/LTCLHP024-G) | True telecentric illuminator, 30 mm beam, 45-90 mm working distance, 124.7 mm long x 44 mm diameter, 2.5 W | Establishes the size class of a real stock 30 mm collimated illuminator; impossible here |

**Inference:** Buying a commercial coaxial light would duplicate the internal
45-degree plate rather than serve as a thin source cartridge. Use these as
architecture and performance references only.

## Recommended modular prototype

Use one external shallow backlight engine and keep the front optical cassette
swappable. Keep the output surface almost flush with the cube face.

```text
rear aluminum/reflector -> LED or edge-lit guide -> mixing diffuser
                                                -> [swappable cartridge]
                                                -> cube opening

cartridge D: clear protector + opal diffuser
cartridge C: clear protector + crossed BEF, or quoted 15 +/-5 degree film
```

Suggested tests, before committing to CAD:

1. Photograph the same white target with cartridge D and C at the actual camera
   and target positions.
2. Record spatial uniformity over the desired 30 x 30 mm ROI and angular spread
   on a screen at two distances.
3. Decide whether the collimated cartridge's contrast improvement is worth its
   brightness loss and possible prism texture.
4. Only if it is, ask Opto Engineering for a 30 mm version of the 3.7 mm,
   15 +/-5-degree filter. Otherwise, standardize the diffuse cartridge.

Optional third coupon: Fresnel Technologies item 0.3 with a small LED near the
15 mm focal plane. It fits the depth but proves a **25 mm point-source
collimator**, not a uniform 30 mm glowing panel.

## Questions that determine the final choice

- Is the required 30 mm shape circular or a true 30 x 30 mm square?
- Is the 15 to 20 mm limit total LED-to-output depth, or only the amount outside
  the cube after the output optic?
- What full output angle is acceptable: 60, 30, 15, 5 degrees, or telecentric?
- Where must uniformity be measured: the source surface, object plane, or camera
  image?
- Is 25 mm useful output acceptable if it enables a Fresnel proof-of-concept?
- What wavelength or white-light spectrum is required?
