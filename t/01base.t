#!/usr/bin/perl -w
use strict;

use Test::More tests => 3;

BEGIN {
	use_ok( 'Devel::Platform::Info' );
	use_ok( 'Devel::Platform::Info::Linux' );
	use_ok( 'Devel::Platform::Info::SCO' );
}
