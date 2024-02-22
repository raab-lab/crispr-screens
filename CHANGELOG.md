raab-lab/crispr-screens: Changelog
==============================

The format of this changelog is based on the [nf-core](https://github.com/nf-core/rnaseq/blob/master/CHANGELOG.md) changelog.

## [3.0] - 2024-02-22

:exclamation: Major Release

This release changes how mageck runs and updates airtable.

### Updates

- The samplesheet includes a new column called SampleNumber (see [docs](docs/params.md)).
- Bumped to pyairtable version 2.1.0.post1 and refactored airtable scripts to accomadate changes to the airtable API (no more API keys).
- mageck runs with singularity instead of conda

## [2.1.1] - 2022-09-01

Random bug fixes because I did a bad job testing before pushing :grimacing:.
`--contrast` needs to be fixed to `--contrasts` in helper scripts.

## [2.1] - 2022-08-26

:exclamation: Big Enhancement

This release integrates Airtable into the pipeline. This should facilitate easier sample sheet creation and provide a single location for all sequencing data to be stored. Additionally, a help parameter was added to display help information (along with extensive doc updates in general).

### Parameters

| Old parameters         | New parameters         |
| ---------------------- | ---------------------- |
|                        | `--new_experiment`     |
|                        | `--pull_samples`	  |
|                        | `--help`	 	  |

## [1.0.0] - 2022-08-17

### Updates

- This is the first release of the DSL2 implementation of the CRISPR pipeline. 

### Parameters

Parameters for the first release can be found [here](docs/params.md).
