##################################
#
# author: graebe
# createdAt: 2014-05-21
# lastUpdate: 2014-05-21

# purpose: Create Projects knowledge base
# call: perl processProjects.pl SPP-Projekte/psp-1.txt

use utf8;
use open      qw(:std :utf8);
#use SparqlQuery;
use strict;

sub createProjectId {
  local $_=shift;
  s/\W/ /gs;
  my @l=split /\s+/;
  $_=$l[0].$l[1].$l[2];
  s/ü/ue/gs;
  s/ö/oe/gs;
  s/ä/ae/gs;
  s/ß/ss/gs;
  #print "$_\n";
  return $_;
}

sub createPersonId {
  local $_=shift;
  s/\.//gs;
  s/-//gs;
  my @l=split /\s+/;
  my $name=pop @l;
  my $initials;
  map { /^(.)/; $initials.=$1; } (@l); 
  $_=$name."_".$initials;
  s/ü/ue/gs;
  s/ö/oe/gs;
  s/ä/ae/gs;
  s/ß/ss/gs;
  s/é/e/gs;
  s/ń/n/gs;
  s/š/s/gs;
  s/ž/z/gs;
  s/č/c/gs;
  s/ć/c/gs;
  s/ř/r/gs;
  s/ů/u/gs;
  s/á/a/gs;
  s/í/i/gs;
  s/ą/a/gs;
  s/\'//gs;
  #print "$_\n";
  return $_;
}

sub TurtleEnvelope {
  my $out=shift;

  return <<EOT
\@prefix owl: <http://www.w3.org/2002/07/owl#> .
\@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
\@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
\@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
\@prefix foaf: <http://xmlns.com/foaf/0.1/> .
\@prefix ical: <http://www.w3.org/2002/12/cal/ical#> .
\@prefix sd: <http://symbolicdata.org/Data/Model#> .
\@prefix sdp: <http://symbolicdata.org/Data/Person/> .
\@prefix swc: <http://data.semanticweb.org/ns/swc/ontology#> .
\@prefix dcterms: <http://purl.org/dc/terms/> .
\@prefix swrc: <http://swrc.ontoware.org/ontology#> .

$out
EOT
}

1;
