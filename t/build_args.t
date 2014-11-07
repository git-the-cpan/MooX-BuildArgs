#!/usr/bin/env perl
use strictures 1;

use Test::More;

require_ok('MooX::BuildArgs');

{
    package Foo;
    use Moo;
    with 'MooX::BuildArgs';
    has get_bar => ( is=>'ro', init_arg=>'bar' );
    has baz => ( is=>'ro' );
}

my $obj = Foo->new( bar=>11, baz=>22 );

is_deeply(
    $obj->build_args(),
    { bar=>11, baz=>22 },
    'worked',
);

done_testing;
