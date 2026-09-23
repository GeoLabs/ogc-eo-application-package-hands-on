#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
id: detect_water_body
label: Water body detection based on NDWI and otsu threshold
doc: Water body detection based on NDWI and otsu threshold
$namespaces:
  s: https://schema.org/
s:softwareVersion: 1.4.1
requirements:
- class: ScatterFeatureRequirement
inputs:
  aoi:
    doc: area of interest as a bounding box
    type: string
  epsg:
    doc: EPSG code
    type: string
    default: EPSG:4326
  bands:
    doc: bands used for the NDWI
    type: string[]
  item:
    doc: STAC item
    type: string
outputs:
- id: detected_water_body
  outputSource:
  - node_otsu/binary_mask_item
  type: File
steps:
  node_crop:
    run: crop.cwl
    in:
      item: item
      aoi: aoi
      epsg: epsg
      band: bands
    out:
    - cropped
    scatter: band
    scatterMethod: dotproduct
  node_normalized_difference:
    run: norm_diff.cwl
    in:
      rasters:
        source: node_crop/cropped
    out:
    - ndwi
  node_otsu:
    run: otsu.cwl
    in:
      raster:
        source: node_normalized_difference/ndwi
    out:
    - binary_mask_item
$schemas:
- http://schema.org/version/9.0/schemaorg-current-http.rdf
