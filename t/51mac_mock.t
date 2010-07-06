#!/usr/bin/perl -w
use strict;

use Test::More;
use Devel::Platform::Info::Mac;

eval "use Test::MockObject::Extends";
plan skip_all => "Test::MockObject::Extends required for these tests" if $@;

plan tests => 9;

my $macInfo = Devel::Platform::Info::Mac->new();
my $mock = Test::MockObject::Extends->new($macInfo);
$mock->set_series('_command', 'Darwin', '10.3', 'PPC', 'Darwin 1', 'uname -a');
my $info = $macInfo->get_info();

is($info->{osname}, 'Mac');
is($info->{osflag}, $^O);
is($info->{oslabel}, 'OS X');
is($info->{codename}, 'Panther');
is($info->{osvers}, '10.3');
is($info->{archname}, 'PPC');
is($info->{is32bit}, 1);
is($info->{is64bit}, 0);
is($info->{kernel}, 'Darwin 1');

use Data::Dumper;
print Dumper($info);
