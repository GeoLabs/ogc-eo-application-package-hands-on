#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
id: water-bodies
label: Water bodies detection based on NDWI and otsu threshold
doc: Water bodies detection based on NDWI and otsu threshold applied to Sentinel-2 COG STAC items
$namespaces:
  s: https://schema.org/
  cwltool: http://commonwl.org/cwltool#
s:softwareVersion: 1.4.1
requirements:
- class: ScatterFeatureRequirement
- class: SubworkflowFeatureRequirement
hints:
- class: cwltool:NetworkAccess
  networkAccess: true
inputs:
  aoi:
    label: area of interest
    doc: area of interest as a bounding box
    type: string
  epsg:
    label: EPSG code
    doc: EPSG code
    type: string
    default: EPSG:4326
  stac_items:
    label: Sentinel-2 STAC items
    doc: list of Sentinel-2 COG STAC items
    type: string[]
  bands:
    label: bands used for the NDWI
    doc: bands used for the NDWI
    type: string[]
    default:
    - green
    - nir
outputs:
- id: stac
  outputSource:
  - node_stac/stac_catalog
  type: Directory
steps:
  node_water_bodies:
    run: detect_water_body.cwl
    in:
      item: stac_items
      aoi: aoi
      epsg: epsg
      bands: bands
    out:
    - detected_water_body
    scatter: item
    scatterMethod: dotproduct
  node_stac:
    run: stac.cwl
    in:
      item: stac_items
      rasters:
        source: node_water_bodies/detected_water_body
    out:
    - stac_catalog
$schemas:
- http://schema.org/version/9.0/schemaorg-current-http.rdf
