##################################
#
# author: graebe
# createdAt: 2014-05-21
# lastUpdate: 2014-05-21

# purpose: Process People 

use Helper;
#use strict;
use utf8;
use open      qw(:std :utf8);
use XML::DOM;

#print processXMLData();
print processLineData();
#print processLineData2();
## end main

sub processXMLData {
  my $parser=new XML::DOM::Parser;
  my $person;
  my $dom=$parser->parse(getData());
  my $cnt=1000;
  my $out="";
  map $out.=processXMLEntry($_), $dom->getElementsByTagName("LI");
  $p=join(", ",@$person);
  $out.=<<EOT;
<ThePersonList> sd:contains $p .
EOT
  return TurtleEnvelope($out);
}

sub processLineData {
  local $_=getData();
  s/\s+\(([^)]*)\)/, $1/gs;
  # print $_;
  my $out="";
  map $out.=processNameAffilEntry($_), split(/\n/,$_);
  $p=join(", ",@$person);
  $out.=<<EOT;
<ThePersonList> sd:contains $p .
EOT
  return TurtleEnvelope($out);
}

sub processLineData2 {
  local $_=getData();
  my $out="";
  map $out.=thePerson($_), split(/\s*\n/,$_);
  $p=join(", ",@$person);
  $out.=<<EOT;
<ThePersonList> sd:contains $p .
EOT
  return TurtleEnvelope($out);
}

#-------------------------------------------------

sub processXMLEntry {
  my $node=shift;
  local $_=$node->toString();
  if (m|<LI><A HREF="(\S+)">(.+)</A></LI>|) {
    return thePerson($2); 
  }
  if (m|<LI>(.+)</LI>|) {
    return thePerson($1); 
  }
}

sub thePerson {
  my $name=shift;
  my $uri=createPersonId($name);
  push(@$person,"sdp:$uri");
  return <<EOT;
sdp:$uri a foaf:Person; foaf:name "$name" .
EOT
}

#-------------------------------------------------

sub processNameAffilEntry {
  local $_=shift;
  my ($name,$affil,$country)=split /\s*,\s*/;
  return thePersonAffil($name,"$affil, $country"); 
}

sub thePersonAffil {
  my ($name,$affil)=@_;
  my $uri=createPersonId($name);
  push(@$person,"sdp:$uri");
  return <<EOT;
sdp:$uri a foaf:Person; foaf:name "$name"; sd:affiliation "$affil" .
EOT
}


#-------------------------------------------------

sub getData {
return <<EOT;
Hirokazu Anai (Kyushu University)
Nikolaj Bjorner (Microsoft Research)
Jonathan Borwein (University of Newcastle)
Bruno Buchberger (RISC Johannes Kepler University)
Xiaoyu Chen (Beihang University)
Changbo Chen (Chinese Academy of Sciences)
Jin-San Cheng (Chinese Academy of Sciences)
Heiko Dietrich (Monash University)
Arie Gurfinkel (Carnegie Mellon University)
Jonathan Hauenstein (North Carolina State University)
Jeff Hooper (Acadia University)
Alexander Hulpke (Colorado State University)
Andres Iglesias (University of Cantabria)
Hidenao Iwane (Fujitsu Laboratories)
Michael Kerber (Max Planck Institute)
Jon-Lark Kim (Sogang University)
Alexander Maletzky (RISC Johannes Kepler University)
David Monniaux (VERIMAG)
Antonio Montes (Universitat Polit?nica de Catalunya)
Marc Moreno Maza (University of Western Ontario)
Marco Pollanen (Trent University)
Yosuke Sato (Tokyo University of Science)
Vikram Sharma (Indian Institute of Mathematical Sciences)
Andrew Sommese (University of Notre Dame)
Setsuo Takato (Toho University)
James Wan (Singapore University)
Dongming Wang (Universite Pierre et Marie Curie)
Dingkang Wang (Chinese Academy of Sciences)
Wolfgang Windsteiger (RISC Johannes Kepler University) 
EOT
}
