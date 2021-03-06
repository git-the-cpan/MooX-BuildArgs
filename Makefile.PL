# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.042.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Save instantiation arguments for later use.",
  "AUTHOR" => "Aran Deltac <bluefeet\@gmail.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "MooX-BuildArgs",
  "LICENSE" => "perl",
  "NAME" => "MooX::BuildArgs",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Moo" => 2,
    "Scalar::Util" => 0,
    "namespace::clean" => "0.24",
    "strictures" => 2
  },
  "TEST_REQUIRES" => {
    "Test::Stream" => "1.302026"
  },
  "VERSION" => "0.02",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Moo" => 2,
  "Scalar::Util" => 0,
  "Test::Stream" => "1.302026",
  "namespace::clean" => "0.24",
  "strictures" => 2
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
