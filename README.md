# Re-call Veritas PGP BAMs

Project to re-call Personal Genome Project BAMs sequenced by Veritas

Veritas collection: https://workbench.su92l.arvadosapi.com/collections/su92l-4zz18-075pax5icw6vpk6

Contains three steps:

1. Unzip .tgz BAMs --> produces BAMs separated by chromosome (done) - folder `unzip/`
2. Variant call each BAM, generating gVCFs (WIP) - folder `recall/`
3. Merge gVCFs by name (todo) folder `merge/`
