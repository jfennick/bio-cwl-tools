#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/star:2.7.5c--0
  SoftwareRequirement:
    packages:
      star:
        specs: [ https://identifiers.org/biotools/star ]
        version: [ "2.7.5c" ]

inputs:
  # Required Inputs
  RunThreadN:
    type: int
    inputBinding:
      prefix: "--runThreadN"

  GenomeDir:
    type: Directory
    inputBinding:
      prefix: "--genomeDir"

  ForwardReads:
    format: edam:format_1930  # FASTQ
    type:
     - File
     - File[]
    inputBinding:
      prefix: "--readFilesIn"
      itemSeparator: ","
      position: 1
  # If paired-end reads (like Illumina), both 1 and 2 must be provided.
  ReverseReads:
    format: edam:format_1930  # FASTQ
    type:
     - "null"
     - File
     - File[]
    inputBinding:
      prefix: ""
      separate: false
      itemSeparator: ","
      position: 2

  # Optional Inputs
  Gtf:
    type: File?
    inputBinding:
      prefix: "--sjdbGTFfile"

  Overhang:
    type: int?
    inputBinding:
      prefix: "--sjdbOverhang"

  OutFilterType:
    type:
     - "null"
     - string
    #  - type: enum
    #    symbols:
    #     - Normal
    #     - BySJout
    inputBinding:
      prefix: "--outFilterType"

  OutFilterIntronMotifs:
    type:
     - "null"
     - string
    #  - type: enum
    #    symbols:
    #     - None
    #     - RemoveNoncanonical
    #     - RemoveNoncanonicalUnannotated
    inputBinding:
      prefix: "--outFilterIntronMotifs"

  OutSAMtype:
    type:
     - "null"
     - string
    #  - type: enum
    #    symbols:
    #     - "BAM"
    #     - "SAM"
    inputBinding:
      prefix: "--outSAMtype"
      position: 3

  Unsorted:
    type: boolean?
    inputBinding:
      prefix: "Unsorted"
      position: 4

  SortedByCoordinate:
    type: boolean?
    inputBinding:
      prefix: "SortedByCoordinate"
      position: 5

  ReadFilesCommand:
    type: string?
    inputBinding:
      prefix: "--readFilesCommand"

  AlignIntronMin:
    type: int?
    inputBinding:
      prefix: "--alignIntronMin"

  AlignIntronMax:
    type: int?
    inputBinding:
      prefix: "--alignIntronMax"

  AlignMatesGapMax:
    type: int?
    inputBinding:
      prefix: "--alignMatesGapMax"

  AlignSJoverhangMin:
    type: int?
    inputBinding:
      prefix: "--alignSJoverhangMin"

  AlignSJDBoverhangMin:
    type: int?
    inputBinding:
      prefix: "--alignSJDBoverhangMin"

  SeedSearchStartLmax:
    type: int?
    inputBinding:
      prefix: "--seedSearchStartLmax"

  ChimOutType:
    type:
     - "null"
     - string
    #  - type: enum
    #    symbols:
    #     - Junctions
    #     - SeparateSAMold
    #     - WithinBAM
    #     - "WithinBAM HardClip"
    #     - "WithinBAM SoftClip"

  ChimSegmentMin:
    type: int?
    inputBinding:
      prefix: "--chimSegmentMin"

  ChimJunctionOverhangMin:
    type: int?
    inputBinding:
      prefix: "--chimJunctionOverhangMin"

  OutFilterMultimapNmax:
    type: int?
    inputBinding:
      prefix: "--outFilterMultimapNmax"

  OutFilterMismatchNmax:
    type: int?
    inputBinding:
      prefix: "--outFilterMismatchNmax"

  OutFilterMismatchNoverLmax:
    type: double?
    inputBinding:
      prefix: "--outFilterMismatchNoverLmax"

  OutReadsUnmapped:
    type:
     - "null"
     - string
    #  - type: enum
    #    symbols:
    #     - None
    #     - Fastx
    inputBinding:
      prefix: "--outReadsUnmapped"

  OutSAMstrandField:
    type:
     - "null"
     - string
    #  - type: enum
    #    symbols:
    #     - None
    #     - intronMotif
    inputBinding:
      prefix: "--outSAMstrandField"

  OutSAMunmapped:
    type:
     - "null"
     - string
    #  - type: enum
    #    symbols:
    #     - None
    #     - Within
    #     - "Within KeepPairs"
    inputBinding:
      prefix: "--outSAMunmapped"

  OutSAMmapqUnique:
    type: int?
    inputBinding:
      prefix: "--outSAMmapqUnique"

  OutSamMode:
    type:
     - "null"
     - string
    #  - type: enum
    #    symbols:
    #     - None
    #     - Full
    #     - NoQS
    inputBinding:
      prefix: "--outSAMmode"

  LimitOutSAMoneReadBytes:
    type: int?
    inputBinding:
      prefix: "--limitOutSAMoneReadBytes"

  OutFileNamePrefix:
    type: string?
    inputBinding:
      prefix: "--outFileNamePrefix"

  GenomeLoad:
    type:
     - "null"
     - string
    #  - type: enum
    #    symbols:
    #     - LoadAndKeep
    #     - LoadAndRemove
    #     - LoadAndExit
    #     - Remove
    #     - NoSharedMemory
    inputBinding:
      prefix: "--genomeLoad"

baseCommand: [STAR, --runMode, alignReads]

outputs:
  unmapped_reads:
    type: ["null", File]
    outputBinding:
      glob: "Unmapped.out*"
# inference chooses outputs in reverse order, so
# move alignment last so that inference will choose alignment
# without having to specify a format.
  alignment:
    type:
     - File
     - File[]
    outputBinding:
      glob: "*.bam"

$namespaces:
  edam: http://edamontology.org/
$schemas:
  - https://edamontology.org/EDAM_1.18.owl
