#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
id: otsu
$namespaces:
  s: https://schema.org/
  ogc: http://www.opengis.net/def/media-type/ogc/1.0/
s:softwareVersion: 1.4.1
requirements:
  InlineJavascriptRequirement: {}
  EnvVarRequirement:
    envDef:
      PATH: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
      PYTHONPATH: /app
  ResourceRequirement:
    coresMax: 1
    ramMax: 1024
hints:
  DockerRequirement:
    dockerPull: ghcr.io/terradue/ogc-eo-application-package-hands-on/otsu:1.5.0
baseCommand:
- python
- -m
- app
arguments: []
inputs:
  raster:
    type: File
    format: ogc:geotiff
    inputBinding:
      position: 1
outputs:
  binary_mask_item:
    outputBinding:
      glob: '*.tif'
    type: File
    format: ogc:geotiff
$schemas:
- http://schema.org/version/9.0/schemaorg-current-http.rdf
