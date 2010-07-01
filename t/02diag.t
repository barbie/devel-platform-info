#!/usr/bin/perl -w
use strict;

use Test::More tests => 1;

use Devel::Platform::Info;
my $info = Devel::Platform::Info->new();
my $data = $info->get_info();

isnt($data,undef);

diag("OS: $^O");
if($data) {
    diag(".. $_ => " . (defined $data->{$_} ? $data->{$_} : ''))   for(keys %$data);
}

