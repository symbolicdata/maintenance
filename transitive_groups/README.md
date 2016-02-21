# Transformation Script for Transitive Groups fingerprints

This transformation is a very first attempt to compile fingerprints from the
collection of transitive groups at http://galoisdb.math.uni-paderborn.de.  Feel
free to adjust the transformation script. 

The perl script transitiveGroups.pl can be run as-is, but it will take a very
long time (probably over an hour) because all data has to be downloaded the
first time.  The second run will be significantly(!) faster (maybe 5 minutes)
because offline copies will be made. The downloaded data was not included here.

The script was compiled by Andreas Nareike in March 2013.

The Transitive Groups fingerprints are part of the SymbolicData data
collection, see http://symbolicdata.org/Data/TransitiveGroups/. 
