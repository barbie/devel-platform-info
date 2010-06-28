package Devel::Platform::Info::Linux;

use strict;
use warnings;

use vars qw($VERSION);
$VERSION = '0.01';

#----------------------------------------------------------------------------

my %commands = (
    '_uname'    => 'uname -a',
    '_lsb'      => 'lsb_release -a',
    'kname'     => 'uname -s',
    'kvers'     => 'uname -r',
    'osname'    => 'uname -o',
    'archname'  => 'uname -m',
);

#----------------------------------------------------------------------------

sub new {
    my ($class) = @_;
    my $self = {};
    bless $self, $class;

    return $self;
}

sub get_info {
    my $self  = shift;

    for my $cmd (keys %commands) {
        $self->{info}{$cmd} = `$commands{$cmd}`;
        $self->{info}{source} .= "$commands{$cmd}\n$self->{info}{$cmd}\n";
        $self->{info}{$cmd} =~ s/\s+$//s;
    }

    $self->{info}{osflag}       = $^O;
    $self->{info}{kernel}       = lc($self->{info}{kname}) . '-' . $self->{info}{kvers};
    ($self->{info}{oslabel})    = $self->{info}{'_lsb'} =~ /Distributor ID:\s*(.*?)\n/si;
    ($self->{info}{osvers})     = $self->{info}{'_lsb'} =~ /Release:\s*(.*?)\n/si;
    ($self->{info}{codename})   = $self->{info}{'_lsb'} =~ /Codename:\s*(.*)\n?/si;

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

Returns the following keys:

  source
  archname
  osname
  osvers
  oslabel
  is32bit
  is64bit
  osflag

  codename
  kernel
  kname
  kvers

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
