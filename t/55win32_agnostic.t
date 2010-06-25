#!/usr/bin/perl -w

# these are for the win32 module but don't require win32 to run

use strict;

use Test::More tests => 17;
use Try::Tiny;

use Devel::Platform::Info::Win32;


my $win32 = Devel::Platform::Info::Win32->new();
my @args = ('', 6, 1, 7600, 2, 0, 0, 256, 1);
my $info = $win32->InterpretWin32Info(@args);
is($info->{osName}, 'Windows');
is($info->{osLabel}, 'Windows 7');
is_deeply($info->{source}, \@args);

my $os;
$os = $win32->InterpretWin32Info('', 4, 0, 3, 1, 2, 1, 1, 1)->{osLabel};
is($os, 'Windows 95');
$os = $win32->InterpretWin32Info('', 4, 0, 3, 0, 2, 1, 1, 1)->{osLabel};
is($os, 'Windows NT 4');
$os = $win32->InterpretWin32Info('', 4, 10, 3, 1, 2, 1, 1, 1)->{osLabel};
is($os, 'Windows 98');
$os = $win32->InterpretWin32Info('', 4, 90, 3, 1, 2, 1, 1, 1)->{osLabel};
is($os, 'Windows Me');
$os = $win32->InterpretWin32Info('', 3, 51, 3, 1, 2, 1, 1, 1)->{osLabel};
is($os, 'Windows NT 3.51');
$os = $win32->InterpretWin32Info('', 6, 0, 3, 1, 2, 1, 1, 1)->{osLabel};
is($os, 'Windows Vista');
$os = $win32->InterpretWin32Info('', 6, 0, 3, 1, 2, 1, 1, 2)->{osLabel};
is($os, 'Windows Server 2008');
$os = $win32->InterpretWin32Info('', 6, 1, 3, 1, 2, 1, 1, 2)->{osLabel};
is($os, 'Windows Server 2008 R2');
$os = $win32->InterpretWin32Info('', 5, 0, 3, 1, 2, 1, 1, 1)->{osLabel};
is($os, 'Windows 2000');
$os = $win32->InterpretWin32Info('', 5, 1, 3, 1, 2, 1, 1, 1)->{osLabel};
is($os, 'Windows XP');

# FIXME: is blank the correct result?
$os = $win32->InterpretWin32Info('', 0, 0, 0, 0, 0, 0, 0, 0)->{osLabel};
is($os, '');

TODO: {
		local $TODO = 'These require me to add calls to other sources of information in order to figure them out.';
		$os = $win32->InterpretWin32Info('', 5, 2, 3790, 2, 2, 0, 272, 2)->{osLabel};
		is($os, 'Windows Server 2003');
		$os = $win32->InterpretWin32Info('', 5, 2, 3790, 2, 2, 0, 272, 2)->{osLabel};
		is($os, 'Windows XP Pro 64');
		$os = $win32->InterpretWin32Info('', 5, 2, 3790, 2, 2, 0, 272, 1)->{osLabel};
		is($os, 'Windows Server 2003 R2');
}

