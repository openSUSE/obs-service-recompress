#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use Test::More tests => 10;
use File::Copy;
use Data::Dumper;

my $temp_dir = $FindBin::Bin."/tmp";
my $in_dir = $FindBin::Bin."/in";
my $data_dir = $FindBin::Bin."/data";
my $test_file = "testfile";
my $last_ext='';

# prepare test environment
( -d $temp_dir ) || mkdir $temp_dir;
( -d $in_dir ) || mkdir $in_dir;
copy("$data_dir/$test_file","$in_dir/$test_file");

# From 		To
# none		gz
# gz		bz2
# bz2		xz
# xz 		zst
# zst 		none

for my $tc (qw/ gz bz2 xz zst none/ ) {

	my $in_file = "$test_file".( ($last_ext) ? ".$last_ext" : '' );
	my $out_file = "$temp_dir/$test_file".( ($tc ne 'none') ? ".$tc" : '' );

	my $cmd="cd $in_dir;$FindBin::Bin/../recompress --outdir $temp_dir --compression $tc --file $in_file;ls $temp_dir;ls";
	`$cmd`;
	ok( -f $out_file,"Checking creation of $tc");
	ok(scalar(list_dir($temp_dir)) == 1,"Checking single file of $tc");
	move($out_file,$in_dir);
	$last_ext = $tc;

}

rm_r($in_dir);
rm_r($temp_dir);

exit 0;

sub list_dir {
	my @res;
	opendir(my $dh,$_[0]);
	while ( my $f = readdir($dh) ) { push(@res, $f) if ( $f ne '.' and $f ne '..') }
	closedir($dh);
	return @res;
}

sub rm_r {
	my $p = $_[0];
	if ( -d $p ) {
		opendir(my $dh,$p)|| die "Error while opening directory $p: $!\n";

		while ( my $f = readdir($dh) ) {
			if ($f ne '.' and $f ne '..') {
				if (-d "$p/$f" ) {
					rm_r("$p/$f") if ( -d "$p/$f" );
				} else {
					unlink "$p/$f" || die "Could not unlink $p/$f: $!\n";
				}
			}
		}
		closedir($dh);
	}
	unlink $p || die "Could not unlink $p: $!\n";
}
