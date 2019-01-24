# Re-call Veritas PGP BAMs

Project to re-call Personal Genome Project BAMs sequenced by Veritas

Veritas collection: https://workbench.su92l.arvadosapi.com/collections/su92l-4zz18-075pax5icw6vpk6

Contains three steps:

1. Unzip .tgz BAMs --> produces BAMs separated by chromosome  
2. Concatenate separated BAMs + sort by header  
3. Create bcbio CWL pipelines for calling with GATK/whatever variant caller
