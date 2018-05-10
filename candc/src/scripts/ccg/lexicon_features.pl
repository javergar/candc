# C&C NLP tools
# Copyright (c) Universities of Edinburgh, Oxford and Sydney
# Copyright (c) James R. Curran
#
# This software is covered by a non-commercial use licence.
# See LICENCE.txt for the full text of the licence.
#
# If LICENCE.txt is not included in this distribution
# please email candc@it.usyd.edu.au to obtain a copy.

%lexicon = ();

$command_line = "# this file was generated by the following command(s):\n";
$command_line .= "# $0 @ARGV\n";

while(<>){
    last if(/^$/);

    if(/^\# /){
	next if(/^\# this file .*generated by the following command/);
	$command_line .= $_;
    }else{
	chomp;
	die "unrecognised preface comment line '%s'\n" % $_;
    }
}

$command_line .= "\n";

print $command_line;

while(<>){
  chomp;
  @fields = split;
  if(/^[0-9]+ [abde] /o){
    $lexicon{$fields[3]}++;
    next;
  }
  if(/^[0-9]+ [LMNPQR]/o){
    $lexicon{$fields[2]}++;
  }
  if(/^[0-9]+ [fghi]/o){
    $lexicon{$fields[2]}++;
    $lexicon{$fields[4]}++
  }
  if(/^[0-9]+ [pqrsFGHIJK] /o){
    $lexicon{$fields[5]}++;
    next;
  }
  if(/^[0-9]+ [tuvw] /o){
    $lexicon{$fields[5]}++;
    $lexicon{$fields[6]}++;
    next;
  }
}

foreach $key (sort { $lexicon{$b} <=> $lexicon{$a} } keys %lexicon){
  print "$key $lexicon{$key}\n";
}
