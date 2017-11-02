use strict;
use FindBin;
use lib "$FindBin::Bin/..";
use Subfunctions;

if (@ARGV < 1) {
	die "Usage: consensus2.pl fastafile\n";
}

my $fastafile = shift;

unless (-e $fastafile) {
	die "File $fastafile does not exist.\n";
}

my ($taxa, $taxanames) = parse_fasta ($fastafile);

print ">$fastafile\n";
while ($taxa->{@$taxanames[0]} ne "") {
	my $currchars = "";
	foreach my $taxon (@$taxanames) {
		if ($taxa->{$taxon} =~ m/(.)(.*)$/) {
			$currchars .= $1;
			$taxa->{$taxon} = $2;
		}
	}
	$currchars = disambiguate_str($currchars);
	print get_iupac_code($currchars);
# 	print get_allele_str($currchars) . "\n";
}

print "\n";
