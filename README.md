# ChEESE-SC9.1

## Directories and files
**geometry**: contains Gmsh files of different cutouts of the whole area. Convert msh-files using
    ElmerGrid 14 2 outline.msh -autoclean -partdual -metiskway 1024
to split the whole problem in 1024 domains (for running with the same amount of MPI ranks)

**Floodpaths**: contains the files (see Input data section below) describing inferred jökulhlaup floodpaths

**wvatnajokull-netCDFs-v2**: geometry data input directory (see Input data section below)

## Workflow
the sequence to run a case is

  1)  `geometry_inlet.sif` to obtain the initial setup from which we can restart the transient run
  2)  `skafta_ve_fsi_wp_el.sif` (for purely elastic) and `skafta_ve_fsi_wp_ve.sif` (for visco-elastic) to run the jökulhlaup simulation

Mind, that the case does not converge properly and depending on the setup might even diverege (see report). 

## Input data for Skaftá Cauldrons jökulhlaup simulations in ChEESE-2P-SC9.1

October 2026 / Tómas Jóhannesson, IMO; Thomas Zwinger, CSC

### Ice surface:
`wvatnajokull-2010-2012-cmb.isn50.zmasl.nc` : 50x50m DEM of the ice surface geometry of Western Vatnajökull based on measurements by aerial lidar in 2010-2012 (Jóhannesson et al., 2013)

`wvatnajokull-2010-2012-cmb.isn50.shade.nc` : --"--, shading

`wvatnajokull-2010-2012-cmb.isn50.zmasl.contour20.shp` : --"--, 20m contours

### (Modelled) subglacial medrock geometry:
`BEDROCK_WVJ3.nc` : 50x50m modelled bedrock DEM based on `wvatnajokull-2010-2012-cmb.isn50.zmasl.nc` and the ice-thickness modelled by Millan et al. (2022)

`BEDROCK_WVJ3_shade.nc` : --"--, shading

### Floodpaths:
`eystri-hlaupleid.shp` : inferred jökulhlaup path from the Eastern Skaftá Cauldron (Einarsson et al., 2016)

`vestari-hlaupleid.shp` : inferred jökulhlaup path from the Western Skaftá Cauldron (Einarsson et al., 2016)

### Note:
The ice-surface and bedrock DEMs are provided in NetCDF format in the Icelandic national ISN93 Lambert projection (EPSG:3057).
The ice thickness used to compute the bedrock geometry is based on remote sensing of ice-flow velocities and ice-flow modelling by Millan et al. (2022) with some adaptation of the ice thickness near the glacier margin to have the subglacial DEM merge smoothly with the landscape of ice-free terrain outside the ice-margin.
The goal of the jökulhlaup simulation is to check the overall plausibility of the SC9.1 numerical jökulhlaup model rather than a detailed back-calculation of a specific jökulhlaup, thus the simplified starting specification using a fixed water potential in a starting area in the upper part of the flood path.
Similarly, the (modelled) bedrock geometry based on remote sensing and ice-flow modelling is intended to provide an overall realistic input specification in terms of the ice-thickness and potential gradient, but may not be expected to be realistic in detail. 

## References:

Einarsson, B., Magnússon, E., Roberts, M. J., Pálsson, F., Thorsteinsson, T., Jóhannesson, T. (2016) A spectrum of jökulhlaup dynamics revealed by GPS measurements of glacier surface motion. Annals of Glaciology, 57, 47–61. https://doi.org/10.1017/aog.2016.8 

Jóhannesson, T., Björnsson, H., Magnússon, E., Guðmundsson, S., Pálsson, F., Sigurðsson, O., Thorsteinsson, Th., Berthier, E. (2013). Ice-volume changes, bias estimation of mass-balance measurements and changes in subglacial lakes derived by lidar mapping of the surface of Icelandic glaciers. Annals of Glaciology. 54(63), 63–74. https://doi.org/10.3189/2013AoG63A422

Millan, R., Mouginot, J., Rabatel, A., Morlighem, M. (2022). Ice velocity and thickness of the world’s glaciers. Nature Geoscience, 15, 124–128.  https://doi.org/10.1038/s41561-021-00885-z
