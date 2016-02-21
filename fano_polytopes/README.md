# Transformation Scripts for Fano Polytope fingerprints

The scripts run on the extracted files of the zip archives at

    http://polymake.org/polytopes/paffenholz/www/fano.html

If you want to run this script you first have to download and extract them.
They extracted data is not included here because:

    (1) redundant data, since it is easily downloaded
    (2) file size (fano-v6d.tgz extracts to over 700 MB)
    (3) number of files (fano-v6d.tgz contains over 7000 single files)

The easiest way to avoid unpacking would be to mount the files with gvfs-mount.

This transformation is a very first attempt to compile fingerprints for Fano
polytopes. Feel free to adjust the transformation script.

The script was compiled by Andreas Nareike in March 2013.

The Fano Polytope fingerprints are part of the SymbolicData data collection,
see http://symbolicdata.org/Data/FanoPolytopes/.
