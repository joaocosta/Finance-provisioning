#!/usr/bin/perl

use strict;
use warnings;

use Parse::CPAN::Packages;
use LWP::Simple;

# http://cpan.org/modules/02packages.details.txt.gz

my $search_dir  = "/home/joao/rpmbuild/RPMS/noarch";
my $cpan_mirror = "http://search.cpan.org/CPAN/authors/id/";
my $download_location   = ".";

my @packages = qw(
Finance::FXCM::Simple
Games::Word
Math::Combinatorics
Pod::Elemental
Pod::Elemental::Transformer::List
String::Truncate
);


getstore("http://cpan.org/modules/02packages.details.txt.gz", "02packages.details.txt.gz");
my $p = Parse::CPAN::Packages->new("02packages.details.txt.gz");

my @specfiles;
my @cpansourcefiles;
foreach my $package (@packages) {
    my $m = $p->package($package);
    my $d = $m->distribution();
    my $rpmname = "perl-" . $d->dist . "-" . $d->version;
    #print $d->filename . "\t" . "\t" . $rpmname . "\n";
    my @exists = glob("$search_dir/$rpmname*.rpm");
    next if (@exists);
    my $url = "$cpan_mirror" . $d->prefix;
    my $rc = getstore($url, $download_location . "/" . $d->filename);
    die($!) if ($rc != 200);
    my $specname = "perl-" . $d->dist . ".spec";
    push @specfiles, $specname;
    push @cpansourcefiles, $d->filename;
}

print "cpanspec $_\n" foreach (@cpansourcefiles);
foreach(@specfiles) {
    print "vimdiff specs/$_ $_\n";
}

print "mach build " . join(" ", @specfiles), "\n";
print 'find /var/tmp/mach/fedora-16-x86_64-updates -name "*rpm" -exec mv -v {} '.$search_dir.' \;' . "\n";
print "createrepo $search_dir\n";
print "rm -v " . join(" ", @cpansourcefiles);
