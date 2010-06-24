package Devel::Platform::Info::Linux;

use strict;
use warnings;

use vars qw($VERSION);
$VERSION = '0.01';

#----------------------------------------------------------------------------

sub new {
    my ($class) = @_;
    my $self = {};
    bless $self, $class;

    return $self;
}

sub get_info {
    my $self  = shift;
    my $uname = `uname -a`;
    my $lsb   = `lsb_release -a`;

    $self->{info}{source} = "uname -a\n$uname\nlsb_release -a\n$lsb\n";
    $self->{info}{kname} = `uname -s`;
    $self->{info}{kvers} = `uname -r`;
    $self->{info}{osname}   = `uname -o`;
    $self->{info}{archname} = `uname -m`;

    $self->{info}{$_} =~ s/\s+$//s  for(qw(kname kvers osname archname));

    $self->{info}{kernel}       = lc($self->{info}{kname}) . '-' . $self->{info}{kvers};
    ($self->{info}{oslabel})    = $lsb =~ /Distributor ID:\s*(.*?)\n/s;
    ($self->{info}{osvers})     = $lsb =~ /Release:\s*(.*?)\n/s;
    ($self->{info}{codename})   = $lsb =~ /Codename:\s*(.*?)\n/s;

    $self->{info}{is32bit}      = $self->{info}{archname} !~ /_(64)$/ ? 1 : 0;
    $self->{info}{is64bit}      = $self->{info}{archname} =~ /_(64)$/ ? 1 : 0;

    return $self->{info};
}

1;

__END__

=head1 NAME

Devel::Platform::Info::Linux - Retrieve common platform metadata

=head1 SYNOPSIS

  use Devel::Platform::Info::Linux;
  my $info = Devel::Platform::Info::Linux->new();
  my $data = $info->get_info();

=head1 DESCRIPTION

This module is a driver to determine platform metadata regarding the Linux
operating system. It should be called indirectly via it's parent 
Devel::Platform::Info

=head1 INTERFACE

=head2 The Constructor

=over

=item * new

Simply constructs the object.

=back

=head2 Methods

=over 4

=item * get_info

Returns a hash reference to the Linux platform metadata.

=back

=head1 BUGS, PATCHES & FIXES

There are no known bugs at the time of this release. However, if you spot a
bug or are experiencing difficulties, that is not explained within the POD
documentation, please send bug reports and patches to the RT Queue (see below).

RT Queue -
http://rt.cpan.org/Public/Dist/Display.html?Name=Devel-Platform-Info

=head1 AUTHORS

  Barbie (BARBIE) <barbie@cpan.org>
  Brian McCauley (NOBULL) <nobull67@gmail.com>
  Colin Newell http://colinnewell.wordpress.com/
  Jon 'JJ' Allen (JONALLEN) <jj@jonallen.info>

=head1 COPYRIGHT & LICENSE

  Copyright (C) 2010 Birmingham Perl Mongers

  This module is free software; you can redistribute it and/or
  modify it under the Artistic License 2.0.

=cut
