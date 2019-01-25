# Running

- This folder contains a python script that generates CWL with bcbio from a collection.

Usage:

`python generate_calling_cwl.py <collection id>`. This generates a `tmp/` folder with a bcbio job template, and generates cwl in another folder, as well as a command to send the job to Arvados.
