package Devel::Platform::Info::Win32;

use strict;
use warnings;
use POSIX;

use vars qw($VERSION);
$VERSION = '0.01';

sub new {
    my ($class) = @_;
    my $self = {};
    bless $self, $class;

    return $self;
}

sub get_info {
	my $self  = shift;

	$self->{info}{osflag}       = $^O;
	my $inf = $self->GetArchName();
	$self->{info}{oslabel} = $inf->{osLabel};
	$self->{info}{osvers} = $inf->{version};
	$self->{info}{archname} = $inf->{archname};
	$self->{info}{is32bit} = $self->{info}{archname} !~ /64/ ? 1 : 0;
	$self->{info}{is64bit} = $self->{info}{archname} =~ /64/ ? 1 : 0;
	$self->{info}{source} = $inf->{source};


	return $self->{info};
}

sub GetArchName
{
	my $self = shift;
	my @uname = POSIX::uname();
	my @versions = Win32::GetOSVersion();
	my $info = $self->InterpretWin32Info(@versions);
	$self->AddPOSIXInfo($info, \@uname);
	return $info;
}

sub AddPOSIXInfo
{
	my $self = shift;
	my $info = shift;
	my $uname = shift;
	my $arch = $uname->[4];
	$info->{archname} = $arch;
	$info->{source} = {
		uname => $uname,
		GetOSVersion => $info->{source},
	};
}

sub InterpretWin32Info
{
	my $self = shift;
	my @versionInfo = @_;
	my ($string, $major, $minor, $build, $id, $spmajor, $spminor, $suitemask, $producttype, @extra)  = @versionInfo;
	my ($osname, $oslabel, $version, $source);
	my %info;
	my $NTWORKSTATION = 1;
	if($major == 5 && $minor == 2)
	{
		# server 2003, win home server
		# server 2003 R2
		# XP Pro 64
		# I need more info from GetSystemMetrics and architecture info to
		# be sure about the exact details.
		$osname = 'Windows Server 2003 / XP 64';
	} elsif($major == 5 && $minor == 1)
	{
		$osname = 'Windows XP';
	} elsif($major == 5 && $minor == 0)
	{
		$osname = 'Windows 2000';
	} elsif($major == 6 && $minor == 1 && $producttype == $NTWORKSTATION)
	{
		$osname = 'Windows 7';
	} elsif($major == 6 && $minor == 1 && $producttype != $NTWORKSTATION)
	{
		$osname = 'Windows Server 2008 R2';
	} elsif($major == 6 && $minor == 0 && $producttype == $NTWORKSTATION)
	{
		$osname = 'Windows Vista';
	} elsif($major == 6 && $minor == 0 && $producttype != $NTWORKSTATION)
	{
		$osname = 'Windows Server 2008';
	} elsif($major == 4 && $minor == 0 && $id == 1)
	{
		$osname = "Windows 95";
	} elsif($major == 4 && $minor == 10)
	{
		$osname = "Windows 98";
	} elsif($major == 4 && $minor == 90)
	{
		$osname = "Windows Me";
	} elsif($major == 4 && $minor == 0)
	{
		$osname = 'Windows NT 4';
	} elsif($major == 3 && $minor == 51)
	{
		$osname = "Windows NT 3.51";
	} else
	{
		$osname = 'Unrecognised - please file an RT case';
	}
	my $info = 
	{
		osName => 'Windows',
		osLabel => $osname,
		version => "$major.$minor.$build.$id",
		source => \@versionInfo,
	};
	return $info;
}


1;

__END__
