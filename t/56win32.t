#!/usr/bin/perl -w

# these are for the win32 module and do require win32

use strict;

use Test::More tests => 1;

eval "use Win32";
my $skip = $@ || '';

eval "use Devel::Platform::Info::Win32";
$skip ||= $@;

SKIP: {
	skip('These tests are only applicable on a win32 platform', 1) if $skip;

	my $win32 = Devel::Platform::Info::Win32->new();
	my $info = $win32->get_info();
	# this doesn't really check whether we got a sensible result
	# more that it didn't crash.
	is($info->{osflag}, $^O);

};
