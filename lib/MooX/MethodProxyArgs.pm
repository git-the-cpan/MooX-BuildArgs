package MooX::MethodProxyArgs;
$MooX::MethodProxyArgs::VERSION = '0.02';
=head1 NAME

MooX::MethodProxyArgs - Invoke code to populate static arguments.

=head1 SYNOPSIS

    package Foo;
    use Moo;
    with 'MooX::MethodProxyArgs';
    has bar => (
        is => 'ro',
    );
    
    package main;
    
    sub divide {
        my ($class, $number, $divisor) = @_;
        return $number / $divisor;
    }
    
    my $foo = Foo->new( bar => ['&proxy', 'main', 'divide', 10, 2 ] );
    
    print $foo->bar(); # 5

=head1 DESCRIPTION

This module munges the class's input arugments by replacing any
method proxy values found with the result of calling the methods.

A method proxy looks like this:

    [ '&proxy', $package, $sub_name, @args ]

When any argument's value is an array ref, where the first value in
the array ref is the string C<&proxy>, then it will be considered to
be a method proxy and the value will be replaced with whatever value
is returned from calling:

    $package->$sub_name( @args );

When your objects support method proxies it can make it much easier
for users of your objects to assign dynamic values to arguments from
static configuration sources, such as configuration files.

=cut

use Moo::Role;
use strictures 2;
use namespace::clean;

with 'MooX::BuildArgsHooks';

around TRANSFORM_BUILDARGS => sub{
    my ($orig, $class, $args) = @_;

    return $class->$orig({
        map { $_ => $class->_run_if_method_proxy( $args->{$_} ) }
        keys( %$args )
    });
};

sub _run_if_method_proxy {
    my ($class, $proxy) = @_;

    return $proxy if ref($proxy) ne 'ARRAY';
    return $proxy if !@$proxy;
    return $proxy if !defined $proxy->[0];
    return $proxy if $proxy->[0] ne '&proxy';

    return $class->_run_method_proxy( $proxy );
}

sub _run_method_proxy {
    my ($class, $proxy) = @_;

    shift( @$proxy );
    my ($package, $method, @args) = @$proxy;

    return $package->$method( @args );
}

1;
__END__

=head1 SEE ALSO

=over

=item *

L<MooX::BuildArgs>

=item *

L<MooX::BuildArgsHooks>

=item *

L<MooX::Rebuild>

=item *

L<MooX::SingleArg>

=back

=head1 AUTHOR

Aran Clary Deltac <bluefeet@gmail.com>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

