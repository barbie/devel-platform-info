use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'          => 'Devel::Platform::Info',
    'VERSION_FROM'  => 'lib/Devel/Platform/Info.pm',
    'PREREQ_PM'     => {
        'IO::File'              => 0,       # only for testing
        'Test::More'            => 0,       # only for testing
    },

    NO_META         => 1,

    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT	=> 'Parse a CPAN Testers NNTP article',
       AUTHOR	=> 'Barbie <barbie@cpan.org>') : ()),
);
