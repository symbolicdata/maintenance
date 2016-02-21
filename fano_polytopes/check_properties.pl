#!/usr/bin/perl
use strict;
use warnings;

# A simple script which globs through the listed
# directories (line 15) and looks for void property
# tags. From those tags it extracts the property
# name and the property value.
#
# Output: all properties with their range

my %properties=();
my $f=0;

my $datadir = "~/data/fano";
my @files = glob("$datadir/fano-v3d/*.* $datadir/fano-v4d/*.* $datadir/fano-v5d/*.* $datadir/fano-v6d/*.*");

foreach my $file (@files) {
    open FILE, $file or die $!;
    $f++;
    while (my $line = <FILE>) {
        if ($line =~ m!<property.*name="([^"]*)".*value="([^"]*)".*/>!) {
            my $key = $1;
            my $val = $2;
            if ($properties{$1}) {
                ${$properties{$1}}{$2} = 1;
            }
            else {
                %{$properties{$1}} = ();
                ${$properties{$1}}{$2} = 1;
            }
        }  
    }    
}

my $thresh = 60;

foreach my $key (keys %properties) {
    my $vals = join(", ", keys %{$properties{$key}});
    if (length $vals > $thresh) {
        $vals = substr($vals, 0, $thresh) . "…"
    }
    print "$key : $vals \n";
}

print "--\n";
print "$f files processed\n";
