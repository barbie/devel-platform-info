package Devel::Platform::Info::Win32;

use strict;
use warnings;
# FIXME: should probably remove this dependency
use Modern::Perl;

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
	$self->{info}{label} = $inf->{osLabel};

    return $self->{info};
}

sub GetArchName
{
	my $self = shift;
	return $self->InterpretWin32Info(Win32::GetOSVersion());
}

sub InterpretWin32Info
{
	my $self = shift;
	my @versionInfo = @_;
	my ($string, $major, $minor, $build, $id, $spmajor, $spminor, $suitemask, $producttype, @extra)  = @versionInfo;
	my ($arch, $osname, $oslabel, $codename, $version, $source, $iswow64);
	my %info;
	my $NTWORKSTATION = 1;
	given($major)
	{
		when(5)
		{
			given($minor)
			{
				when(2)
				{
					# server 2003, win home server
					# server 2003 R2
					# XP Pro 64
					# I need more info from GetSystemMetrics and architecture info to
					# be sure about the exact details.
					$osname = 'Windows Server 2003 / XP 64';
				}
				when(1)
				{
					# XP
					$osname = 'Windows XP';
				}
				when(0)
				{
					$osname = 'Windows 2000';
				}
			}
		}
		when(6)
		{
			given($minor)
			{
				when(1)
				{
					if($producttype == $NTWORKSTATION)
					{
						$osname = 'Windows 7';
					}
					else
					{
						$osname = 'Windows Server 2008 R2';
					}
				}
				when(0)
				{
					if($producttype == $NTWORKSTATION)
					{
						$osname = 'Windows Vista';
					}
					else
					{
						$osname = 'Windows Server 2008';
					}
				}
			}
		}
		when(4)
		{
			given($minor)
			{
				when(0)
				{
					if($id == 1)
					{
						$osname = "Windows 95";
					}
					else
					{
						$osname = 'Windows NT 4';
					}
				}
				when(10)
				{
					$osname = "Windows 98";
				}
				when(90)
				{
					$osname = "Windows Me";
				}
			}
		}
		when(3)
		{
			if($minor == 51)
			{
				$osname = "Windows NT 3.51";
			}
		}
		default
		{
			$osname = '';
			$codename = '';
		}
	}
	my $info = 
	{
		osName => 'Windows',
		osLabel => $osname,
		codeName => $codename,
		version => "$major.$minor.$build.$id",
		source => \@versionInfo,
	};
	return $info;
}


1;

__END__
