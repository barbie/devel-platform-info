use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'          => 'Devel::Platform::Info',
    'VERSION_FROM'  => 'lib/Devel/Platform/Info.pm',
    'PREREQ_PM'     => {
        'Test::More'    => 0,   # only for testing
    },

    NO_META         => 1,

    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT => 'Unified framework for obtaining common platform metadata',
       AUTHOR   => 'Barbie <barbie@cpan.org>') : ()),
);
