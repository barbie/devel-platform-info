package Devel::Platform::Info::Linux;

use strict;
use warnings;

use vars qw($VERSION);
$VERSION = '0.09';

#----------------------------------------------------------------------------

my %commands = (
    '_issue1'   => 'cat /etc/issue',
    '_issue2'   => 'cat /etc/.issue',
    '_uname'    => 'uname -a',
    '_lsb'      => 'lsb_release -a',
    'kname'     => 'uname -s',
    'kvers'     => 'uname -r',
    'osname'    => 'uname -o',
    'archname'  => 'uname -m',
);

my %default = ();

my %archlinux = (
    '0.1'       => 'Homer',
    '0.2'       => 'Vega',
    '0.3'       => 'Firefly',
    '0.4'       => 'Dragon',
    '0.5'       => 'Nova',
    '0.6'       => 'Widget',
    '0.7'       => 'Wombat',
    '0.8'       => 'Voodoo',
    '2007.05'   => 'Duke',
    '2007.08'   => "Don't Panic",
    '2008.06'   => 'Overlord',
    '2009.02'   => '2009.02',
    '2009.08'   => '2009.08',
    '2010.05'   => '2010.05',
);

my %debian = (
    '1.1'       => 'buzz',
    '1.2'       => 'rex',
    '1.3'       => 'bo',
    '2.0'       => 'hamm',
    '2.1'       => 'slink',
    '2.2'       => 'potato',
    '3.0'       => 'woody',
    '3.1'       => 'sarge',
    '4.0'       => 'etch',
    '5.0'       => 'lenny',
    '6.0'       => 'squeeze',
    '7.0'       => 'wheezy',
);

my %fedora = (
    '1'         => 'Yarrow',
    '2'         => 'Tettnang',
    '3'         => 'Heidelberg',
    '4'         => 'Stentz',
    '5'         => 'Bordeaux',
    '6'         => 'Zod',
    '7'         => 'Moonshine',
    '8'         => 'Werewolf',
    '9'         => 'Sulphur',
    '10'        => 'Cambridge',
    '11'        => 'Leonidas',
    '12'        => 'Constantine',
    '13'        => 'Goddard',
    '14'        => 'Laughlin',
);

my %mandriva = (
    '5.1'       => 'Venice',
    '5.2'       => 'Leeloo',
    '5.3'       => 'Festen',
    '6.0'       => 'Venus',
    '6.1'       => 'Helios',
    '7.0'       => 'Air',
    '7.1'       => 'Helium',
    '7.2'       => 'Odyssey (called Ulysses during beta)',
    '8.0'       => 'Traktopel',
    '8.1'       => 'Vitamin',
    '8.2'       => 'Bluebird',
    '9.0'       => 'Dolphin',
    '9.1'       => 'Bamboo',
    '9.2'       => 'FiveStar',
    '10.0'      => 'Community and Official',
    '10.1'      => 'Community',
    '10.1'      => 'Official',
    '10.2'      => 'Limited Edition 2005',
    '2006.0'    => 'Mandriva Linux 2006',
    '2007'      => 'Mandriva Linux 2007',
    '2007.1'    => 'Mandriva Linux 2007 Spring',
    '2008.0'    => 'Mandriva Linux 2008',
    '2008.1'    => 'Mandriva Linux 2008 Spring',
    '2009.0'    => 'Mandriva Linux 2009',
    '2009.1'    => 'Mandriva Linux 2009 Spring',
    '2010.0'    => 'Mandriva Linux 2010 (Adélie)',
    '2010.1'    => 'Mandriva Linux 2010 Spring',
    '2010.2'    => 'Mandriva Linux 2010.2',
);

my %ubuntu = (
    '4.10'      => 'Warty Warthog',
    '5.04'      => 'Hoary Hedgehog',
    '5.10'      => 'Breezy Badger',
    '6.06'      => 'Dapper Drake',
    '6.10'      => 'Edgy Eft',
    '7.04'      => 'Feisty Fawn',
    '7.10'      => 'Gutsy Gibbon',
    '8.04'      => 'Hardy Heron',
    '8.10'      => 'Intrepid Ibex',
    '9.04'      => 'Jaunty Jackalope',
    '9.10'      => 'Karmic Koala',
    '10.04'     => 'Lucid Lynx',
    '10.10'     => 'Maverick Meerkat',
    '11.04'     => 'Natty Narwhal',
);

my %scientific = (
    '3.0.1'     => 'Feynman',
    '3.0.2'     => 'Feynman',
    '3.0.3'     => 'Feynman',
    '3.0.4'     => 'Feynman',
    '3.0.5'     => 'Feynman',
    '3.0.6'     => 'Feynman',
    '3.0.7'     => 'Feynman',
    '3.0.8'     => 'Feynman',
    '3.0.9'     => 'Legacy',
    '4.0'       => 'Beryllium',
    '4.1'       => 'Beryllium',
    '4.2'       => 'Beryllium',
    '4.3'       => 'Beryllium',
    '4.4'       => 'Beryllium',
    '4.5'       => 'Beryllium',
    '4.6'       => 'Beryllium',
    '4.7'       => 'Beryllium',
    '4.8'       => 'Beryllium',
    '5.0'       => 'Boron',
    '5.1'       => 'Boron',
    '5.2'       => 'Boron',
    '5.3'       => 'Boron',
    '5.4'       => 'Boron',
    '5.5'       => 'Boron',
    '6.0'       => 'Carbon',
);

my %distributions = (
    'Adamantix'             => { codenames => \%default,                        files => [ qw( /etc/adamantix_version ) ] },
    'Annvix'                => { codenames => \%default,                        files => [ qw( /etc/annvix-release ) ] },
    'Arch Linux'            => { codenames => \%archlinux,                      files => [ qw( /etc/arch-release ) ] },
    'Arklinux'              => { codenames => \%default,                        files => [ qw( /etc/arklinux-release ) ] },
    'Aurox Linux'           => { codenames => \%default,                        files => [ qw( /etc/aurox-release ) ] },
    'BlackCat'              => { codenames => \%default,                        files => [ qw( /etc/blackcat-release ) ] },
    'Cobalt'                => { codenames => \%default,                        files => [ qw( /etc/cobalt-release ) ] },
    'Conectiva'             => { codenames => \%default,                        files => [ qw( /etc/conectiva-release ) ] },
    'Debian'                => { codenames => \%debian,     key => 'debian',    files => [ qw( /etc/debian_version /etc/debian_release ) ] },
    'Fedora Core'           => { codenames => \%fedora,     key => 'fedora',    files => [ qw( /etc/fedora-release ) ] },
    'Gentoo Linux'          => { codenames => \%default,    key => 'gentoo',    files => [ qw( /etc/gentoo-release ) ] },
    'Immunix'               => { codenames => \%default,                        files => [ qw( /etc/immunix-release ) ] },
    'Knoppix'               => { codenames => \%default,                        files => [ qw( /etc/knoppix_version ) ] },
    'Libranet'              => { codenames => \%default,                        files => [ qw( /etc/libranet_version ) ] },
    'Linux-From-Scratch'    => { codenames => \%default,                        files => [ qw( /etc/lfs-release ) ] },
    'Linux-PPC'             => { codenames => \%default,                        files => [ qw( /etc/linuxppc-release ) ] },
    'Mandrake'              => { codenames => \%mandriva,                       files => [ qw( /etc/mandrake-release ) ] },
    'Mandriva'              => { codenames => \%mandriva,                       files => [ qw( /etc/mandriva-release /etc/mandrake-release /etc/mandakelinux-release ) ] },
    'Mandrake Linux'        => { codenames => \%mandriva,                       files => [ qw( /etc/mandriva-release /etc/mandrake-release /etc/mandakelinux-release ) ] },
    'MkLinux'               => { codenames => \%default,                        files => [ qw( /etc/mklinux-release ) ] },
    'Novell Linux Desktop'  => { codenames => \%default,                        files => [ qw( /etc/nld-release ) ] },
    'Pardus'                => { codenames => \%default,    key => 'pardus',    files => [ qw( /etc/pardus-release ) ] },
    'PLD Linux'             => { codenames => \%default,                        files => [ qw( /etc/pld-release ) ] },
    'Red Flag'              => { codenames => \%default,    key => 'redflag',   files => [ qw( /etc/redflag-release ) ] },
    'Red Hat'               => { codenames => \%default,    key => 'redhat',    files => [ qw( /etc/redhat-release /etc/redhat_version ) ] },
    'Scientific Linux'      => { codenames => \%scientific,                     files => [ qw( /etc/lsb-release ) ] },
    'Slackware'             => { codenames => \%default,    key => 'slackware', files => [ qw( /etc/slackware-version /etc/slackware-release ) ] },
    'SME Server'            => { codenames => \%default,                        files => [ qw( /etc/e-smith-release ) ] },
    'Sun JDS'               => { codenames => \%default,                        files => [ qw( /etc/sun-release ) ] },
    'SUSE Linux'            => { codenames => \%default,    key => 'suse',      files => [ qw( /etc/SuSE-release /etc/novell-release ) ] },
    'SUSE Linux ES9'        => { codenames => \%default,    key => 'suse',      files => [ qw( /etc/sles-release ) ] },
    'Tiny Sofa'             => { codenames => \%default,                        files => [ qw( /etc/tinysofa-release ) ] },
    'Trustix Secure Linux'  => { codenames => \%default,                        files => [ qw( /etc/trustix-release ) ] },
    'TurboLinux'            => { codenames => \%default,                        files => [ qw( /etc/turbolinux-release ) ] },
    'Ubuntu Linux'          => { codenames => \%ubuntu,                         files => [ qw( /etc/lsb-release ) ] },
    'UltraPenguin'          => { codenames => \%default,                        files => [ qw( /etc/ultrapenguin-release ) ] },
    'UnitedLinux'           => { codenames => \%default,                        files => [ qw( /etc/UnitedLinux-release ) ] },
    'VA-Linux/RH-VALE'      => { codenames => \%default,                        files => [ qw( /etc/va-release ) ] },
    'Yellow Dog'            => { codenames => \%default,                        files => [ qw( /etc/yellowdog-release ) ] },
    'Yoper'                 => { codenames => \%default,                        files => [ qw( /etc/yoper-release ) ] },
);

my %version_pattern = (
    'gentoo'    => 'Gentoo Base System version (.*)',
    'debian'    => '(.+)',
    'suse'      => 'VERSION = (.*)',
    'fedora'    => 'Fedora Core release (\d+) \(',
    'redflag'   => 'Red Flag (?:Desktop|Linux) (?:release |\()(.*?)(?: \(.+)?\)',
    'redhat'    => 'Red Hat Linux release (.*) \(',
    'slackware' => '^Slackware (.+)$',
    'pardus'    => '^Pardus (.+)$',
);

my %oslabel_pattern = (
    'suse'      => '^(\S+)',
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
        $self->{cmds}{$cmd} = `$commands{$cmd} 2>/dev/null`;
        $self->{cmds}{$cmd} =~ s/\s+$//s;
        $self->{info}{$cmd} = $self->{cmds}{$cmd}   if($cmd =~ /^[^_]/);
    }

    $self->{info}{osflag}       = $^O;
    $self->{info}{kernel}       = lc($self->{info}{kname}) . '-' . $self->{info}{kvers};

    $self->{info}{is32bit}      = $self->{info}{archname} !~ /_(64)$/ ? 1 : 0;
    $self->{info}{is64bit}      = $self->{info}{archname} =~ /_(64)$/ ? 1 : 0;

    if($self->{cmds}{'_lsb'}) {
        ($self->{info}{oslabel})    = $self->{cmds}{'_lsb'} =~ /Distributor ID:\s*(.*?)\n/si;
        ($self->{info}{osvers})     = $self->{cmds}{'_lsb'} =~ /Release:\s*(.*?)\n/si;
        ($self->{info}{codename})   = $self->{cmds}{'_lsb'} =~ /Codename:\s*(.*)\n?/si;
    } else {
        $self->_release_version();
    }

    $self->{info}{source}{$commands{$_}} = $self->{cmds}{$_}    for(keys %commands);
    return $self->{info};
}

#----------------------------------------------------------------------------

sub _release_version {
    my $self = shift;

    for my $label (keys %distributions) {
        for my $file (@{ $distributions{$label}->{files} }) {
            next    unless(-f $file);
            my $line = `cat $file 2>/dev/null`;

            my ($version,$oslabel);
            if($distributions{$label}->{key}) {
                if($version_pattern{ $distributions{$label}->{key} }) {
                    ($version) = $line =~ /$version_pattern{ $distributions{$label}->{key} }/si;
                }
                if($oslabel_pattern{ $distributions{$label}->{key} }) {
                    ($oslabel) = $line =~ /$oslabel_pattern{ $distributions{$label}->{key} }/si;
                }
            }

            $version = $line    unless($version);
            $version =~ s/\s*$//;

            unless($oslabel) {
                if($self->{cmds}{'_issue1'}) {
                    ($oslabel) = $self->{cmds}{'_issue1'} =~ /^(\S*)/;
                } elsif($self->{cmds}{'_issue2'}) {
                    ($oslabel) = $self->{cmds}{'_issue2'} =~ /^(\S*)/;
                }
                $oslabel ||= $label;    # a last resort
            }

            $self->{info}{oslabel}  = $oslabel;
            $self->{info}{osvers}   = $version;
            $commands{'_cat'} = "cat $file";
            $self->{cmds}{'_cat'}  = $line;

            for my $vers (keys %{ $distributions{$label}->{codenames} }) {
                if($version =~ /^$vers\b/) {
                    $self->{info}{codename} = $distributions{$label}->{codenames}{$vers};
                    return;
                }
            }

            return;
        }
    }
}

1;

__END__

=head1 NAME

Devel::Platform::Info::Linux - Retrieve Linux platform metadata

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

=head1 REFERENCES

The following links were used to understand how to retrieve the metadata:

  * http://distrowatch.com/
  * Wikipedia pages for various Linux and Unix based OSes
  * http://search.cpan.org/dist/Sys-Info-Driver-Linux

=head1 BUGS, PATCHES & FIXES

There are no known bugs at the time of this release. However, if you spot a
bug or are experiencing difficulties, that is not explained within the POD
documentation, please send bug reports and patches to the RT Queue (see below).

RT Queue: http://rt.cpan.org/Public/Dist/Display.html?Name=Devel-Platform-Info

=head1 AUTHORS

  Barbie (BARBIE) <barbie@cpan.org>
  Brian McCauley (NOBULL) <nobull67@gmail.com>
  Colin Newell http://colinnewell.wordpress.com/
  Jon 'JJ' Allen (JONALLEN) <jj@jonallen.info>

=head1 COPYRIGHT & LICENSE

  Copyright (C) 2010-2011 Birmingham Perl Mongers

  This module is free software; you can redistribute it and/or
  modify it under the Artistic License 2.0.

=cut
