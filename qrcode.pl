#!/usr/bin/env perl

use strict;
use warnings;

use Term::ANSIColor;
use Text::QRCode;

my $code = join("\n", map { join '', @$_ } @{Text::QRCode->new()->plot($ARGV[1]||"BOOM!")});

my $white = 'white on_white';
my $black = 'black on_black';

my $repeat = 2;
my $border_width = 8;
my $top_border_width = length((split /\n/, $code)[0])*2 + ($border_width * 2);

foreach (1..$border_width/2) {
	print colored [$white], ' 'x$top_border_width;
	print "\n";
}
foreach my $line(split /\n/, $code) {
	print colored [$white], ' 'x$border_width;
	foreach my $char (split //, $line) {
		if ($char =~ /^\s/) { print colored [$white], ($char)x$repeat }
		else {print colored [$black], ($char)x$repeat }
	}
	print colored [$white], ' 'x$border_width;
	print "\n";
}
foreach (1..$border_width/2) {
	print colored [$white], ' 'x$top_border_width;
	print "\n";
}
