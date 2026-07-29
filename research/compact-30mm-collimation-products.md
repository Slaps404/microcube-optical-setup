# Compact 30 mm illumination and collimation products

Scope: manufacturer-published products and datasheets relevant to a roughly 30 mm square illuminated face with only 15-20 mm of optical depth. Dimensions below are manufacturer values. "Fits" refers only to the optical envelope, not PCB, heatsink, wiring, or mounting clearance.

Geometry correction: measurement of `exports/microcube-base.stl` and the
official `CubeSize(size=40, d=7)` default supersede the earlier 52 mm interior
interpretation. The cube has a 40 mm clear span, 54 mm face, and 68 mm overall
envelope. A 30 mm face-normal field still fits the beamsplitter's nominal
35.36 mm projected width. The 2.32 mm plate-to-face endpoint clearance requires
a flush output, with commercial housings remaining outside.

## Best physical fits

| Product | Manufacturer facts | Availability | Fit and limitation |
|---|---|---|---|
| [Carclo 10610 10 mm Quad Optic](https://www.carclo-optics.com/products/optic-10610) | The manufacturer drawing shows a 19.9 x 19.9 mm square flange, a 2 x 2 lens grid, 17 mm lens-grid width, and a 6.0 mm vertical dimension. The product is a four-cell narrow-spot TIR optic. With Nichia 757 white LEDs, Carclo publishes 14.5 deg FWHM and 90.5% optical efficiency. [Drawing](https://www.carclo-optics.com/sites/default/files/images/optics/10610_Iss2_190210.pdf) | Manufacturer offers sample request and sales contact. | Easily fits the depth. It creates four individual beams, not an intrinsically uniform 30 mm square field. It is a useful compact LED-array prototype only if a diffuser/mixing layer is added and the resulting camera-plane uniformity is measured. |
| [Fresnel Technologies ASP-PCX-0.5-0.5P-PMMA](https://www.fresneltech.com/hubfs/Spec%20Sheets/Polymer%20Aspheres_2024.pdf) | Ready-to-ship PMMA asphere: 12.7 mm mount diameter, 12.7 mm EFL, 9.4 mm BFL, 4.92 mm center thickness, 2.0 mm edge thickness, f/1. Source-to-front-vertex distance is approximately BFL + CT = 14.3 mm. | Explicitly listed as ready-to-ship; coatings are optional suffixes. | Fits 15 mm optical depth, but the clear/output aperture is only about 12.7 mm and round. A 2 x 2 array could fit a roughly 25.4 mm square envelope, but beam seams and alignment remain. |
| [Fresnel Technologies catalog lens #0.3](https://www.fresneltech.com/hubfs/Spec%20Sheets/Fresnel%20Lens%20Brochure.pdf?hsLang=en) | Positive aspheric Fresnel: 15 mm focal length, 25 mm well-centered Fresnel size, 38 x 38 mm stock blank, 1.5 mm thickness, 200 grooves/inch. The catalog says alternate cuts can be accommodated as special orders. | Catalog/order-inquiry product; price and lead time require sales confirmation. | The 15 mm focal spacing plus 1.5 mm sheet fits the optical-depth target if the 38 mm blank is cropped. The active field is about 25 mm and not a 30 mm square. Best simple point-source collimator found. |
| [3M BEF3-T-155n](https://multimedia.3m.com/mws/media/1245088O/3m-brightness-enhancement-films-3m-bef-technical-data-sheet.pdf) | Prismatic brightness-enhancement film, 155 +/- 10 micrometers thick, 90 deg prism angle, 50 micrometer pitch, effective transmission 1.53. 3M states that one sheet compresses the viewing angle mainly in one axis; two sheets crossed at 90 deg compress both axes. [Application guide](https://multimedia.3m.com/mws/media/1839627O/3m-brightness-film-app-guide-75050141318-pdf.pdf) | Industrial film sold through 3M/contact channels; designed to be converted/cut to the cavity. | Essentially no depth cost, and it can be cut to 30 mm square. It is not a true collimator and does not create spatial uniformity. It needs a diffuse backlight and recycling cavity beneath it. Two crossed sheets are the relevant configuration. |

## Homogenizer and fly-eye references

| Product | Manufacturer facts | Availability | Fit and limitation |
|---|---|---|---|
| [INGENERIC Homogenizer Array-19.4](https://ingeneric.com/wp-content/uploads/2020/01/INGENERIC_MLA_2020-1.pdf) | 30 x 26 x 2.0 mm cylindrical microlens array, 19.4 mm EFL, 0.8 mm pitch, high-index K-VC89 glass. The same datasheet gives <2 micrometer pitch error across 25 mm, <100 nm form error, and <1% EFL tolerance for this array family. | Manufacturer describes most arrays as custom solutions, from prototypes through production; request quote. | Its face size is unusually close to the target. A fly-eye homogenizer system still normally requires paired arrays and/or a field lens, so the complete optical train is not guaranteed to fit 20 mm. This is the best vendor to ask for a custom monolithic 30 mm-class homogenizer. |
| [Edmund #12-844 fly's-eye array](https://www.edmundoptics.com/p/flys-eye-array-10-x-10mm-350microm-pitch-65deg-divergence/41536/?PrintPDF=true) | 10 x 10 x 2.25 mm fused-silica, double-convex fly-eye array; 9 x 9 mm clear aperture; 350 micrometer pitch; 1.59 mm EFL; +/-6.5 deg divergence. Manufacturer page listed 15 in stock at the research date. | Stocked, but approximately $915 each at the research date. | Thin and square, but only 9 mm clear aperture. It is not a 30 mm solution unless tiled, which would add seams and high cost. |
| [Edmund #21-147 microlens array](https://www.edmundoptics.com/p/microlens-array-10-x-10mm-300m-pitch-05-divergence-nir-ii-coated/47902/?PrintPDF=true) | 10 x 10 x 1.2 mm fused-silica PCX microlens array, 18.8 mm EFL, 300 micrometer pitch, +/-0.5 deg divergence. The cited version is NIR-II coated. | Manufacturer listed it for purchase at approximately $1,040 at the research date. | Demonstrates that very low divergence can fit the nominal depth, but only for a 9-10 mm aperture and a compatible source array. Not a white-visible, 30 mm square solution as sold. |

Important system-level point: G&H's manufacturer overview states that a [fly's-eye homogenizer uses two identical aligned lens plates](https://gandh.com/products/polymer-optics/refractive-polymer-optics/flys-eye-lenses), with each lenslet pair dividing and overlapping the incident beam. A single fly-eye plate should not be assumed to produce a flat, uniform field by itself.

## Commercial coaxial/collimated lights: useful near-misses

| Product | Manufacturer facts | Availability | Why it does not fit |
|---|---|---|---|
| [Opto Engineering LT2QOG025-00-X-R-24V](https://www.opto-e.com/en/products/ltcxc-series/LT2QOG025-00-X-R-24V) | Coaxial LED light with a 25.6 x 27 mm emitting area, 20-40 mm optimal working distance, 0 deg nominal emission angle, 4,910 lux, and 33 x 33 x 54 mm body. | Current product page with datasheet/contact route. | This is the closest commercial coaxial-light face size found, but its 54 mm length is roughly three times the allowed optical depth. It is red only in this exact SKU. |
| [Opto Engineering LTCLHP024-G](https://www.opto-e.com/en/products/ltclhp-series/LTCLHP024-G) | Telecentric illuminator with 30 mm beam, 45-90 mm working range, 44 mm front diameter, 124.7 mm length, 525 nm green output. | Current manufacturer product, last page update October 2025. | Confirms that a high-quality commercial 30 mm collimated beam generally needs far more path length than 15-20 mm. |

## Light-pipe result

No stock square light pipe close to 30 mm aperture and 15-20 mm length was found from the searched primary-source catalogs. The closest catalog class is much longer:

- [Edmund 10 mm-aperture fused-silica light pipe](https://www.edmundoptics.com/p/10mm-aperture-x-125mm-l-standard-na-fused-silica-light-pipe/17710/) is 125 mm long and was listed 20+ in stock. Edmund explains that lower-NA sources need longer pipes, while high-NA sources can homogenize in shorter pipes. This is evidence that a 15-20 mm custom rod is risky without optical simulation and a high-NA input.
- [SCHOTT light-guide rods](https://media.schott.com/api/public/content/86dfd97fbf7c43f8aec79e358d09a338?download=true&v=69b68a3e) are custom-shaped, but its current technical sheet gives a 1-19 mm single-core rod size range, not a stock 30 mm square homogenizer.

## Design conclusion

There is no verified stock component that simultaneously provides a 30 mm square, spatially uniform, strongly collimated white field within 15-20 mm depth.

The two defensible prototype strategies are:

1. **Thin backlight stack:** a 3 x 3 or 4 x 4 LED PCB inside a white reflective mixing cavity, diffuser, then two crossed 3M BEF sheets. This best matches the square/even/compact goals, but provides angular compression rather than true collimation.
2. **Point-source collimator:** crop Fresnel Technologies #0.3 to the mechanical envelope and place a compact LED approximately 15 mm behind it. This best matches the collimation/depth goals, but only offers about a 25 mm active aperture and will not automatically be spatially uniform or square.

The Carclo 10610 is the fastest low-cost compact optical prototype between those extremes. The INGENERIC 30 x 26 mm array is the strongest custom-vendor lead if measured uniformity justifies higher cost.
