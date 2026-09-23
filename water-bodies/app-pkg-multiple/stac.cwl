#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
id: stac
$namespaces:
  s: https://schema.org/
s:softwareVersion: 1.4.1
requirements:
  InlineJavascriptRequirement: {}
  EnvVarRequirement:
    envDef:
      PATH: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
      PYTHONPATH: /app
  ResourceRequirement:
    coresMax: 1
    ramMax: 512
hints:
  DockerRequirement:
    dockerPull: ghcr.io/terradue/ogc-eo-application-package-hands-on/stac:1.5.0
baseCommand:
- python
- -m
- app
arguments: []
inputs:
  item:
    type:
      type: array
      items: string
      inputBinding:
        prefix: --input-item
  rasters:
    type:
      type: array
      items: File
      inputBinding:
        prefix: --water-body
outputs:
  stac_catalog:
    outputBinding:
      glob: .
    type: Directory
$schemas:
- http://schema.org/version/9.0/schemaorg-current-http.rdf
