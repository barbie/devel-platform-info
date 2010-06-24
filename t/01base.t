#!/usr/bin/perl -w
use strict;

use Test::More tests => 2;

BEGIN {
	use_ok( 'Devel::Platform::Info' );
	use_ok( 'Devel::Platform::Info::Linux' );
}
