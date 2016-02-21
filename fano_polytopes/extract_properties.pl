#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;

my $NS = "http://symbolicdata.org/Data/FanoPolytope/";
my $NSP = "sd";

my $datadir = "~/data/fano";
my @files = glob("$datadir/fano-v3d/*.* $datadir/fano-v4d/*.* $datadir/fano-v5d/*.* $datadir/fano-v6d/*.*");

my $ResURL = "http://polymake.org/polytopes/paffenholz/data/smooth-fano/";

my @intprops = ("n_vertices", "n_facets", "cone_ambient_dim", "cone_dim", "facet_width", "n_edges");

print getPreamble();

foreach my $file (@files) {
    open FILE, $file or die $!;
    my($polyname,$path,$suffix) = fileparse($file);
    my $zip = "<".$ResURL.basename($path).".tgz>";

    my @properties = ();
    my @files = {};
    my $countname = undef;

    # my %count = (
    #     VERTICES => 0,        
    # );

    while (my $line = <FILE>) {
        # if ($line =~ m!property.*name="([^"]*)"!) {
        #     my $key = $1;
        #     if (exists $count{$key}) {
        #         # set name to count
        #         $countname = $key;
        #         # print "Setting count key to $key\n";
        #     }
            if ($line =~ m!<property.*name="([^"]*)".*value="([^"]*)".*/>!) {
                my $prop = lc $1;
                my $val = $2;
                if ($prop ~~ @intprops) {
                    push @properties, "     $NSP:$prop \"$val\"^^xsd:integer";
                }
                else {
                    push @properties, "     $NSP:$prop \"$val\"";
                }
            }  
        # }
        # if ($line =~ m!<v>! && $countname) {
        #     $count{$countname}++;
        # }
        # if ($line =~ m!</m>!) {
        #     $countname = undef;
        # }
    }

    $file =~ m!f[a-z]*-v?(\d)*[d-].*/(.*)!;
    my $dim = $1;
    my $name = $2;

    my $ttl=<<EOF;
<$NS$name> a sd:FanoPolytope ;
     $NSP:hasDimension "$dim" ;
     $NSP:inZIPFile $zip ;
     $NSP:hasFileName "$polyname" ;
EOF
    # foreach my $key (keys %count) {
    #     $ttl.="     $NSP:".lc $key.' "'.$count{$key}.'"'." ;\n";
    # }

    $ttl.=join(" ;\n", @properties)." .\n";

    print $ttl . "\n";
}


sub getPreamble {
    return <<'EOF';
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix sd: <http://symbolicdata.org/Data/Model/> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

<http://symbolicdata.org/Data/FanoPolytopes/>
    a owl:Ontology ;
rdfs:comment "Smooth Reflexive Lattice Polytopes Data from the Polymake project (www.polymake.org), collected by Andreas Paffenholz (http://www.mathematik.tu-darmstadt.de/~paffenholz/)" ;
    rdfs:label "SD FanoPolytopes" .

sd:FanoPolytope
    a owl:Class ;
    rdfs:label "FanoPolytope" .

EOF
}
