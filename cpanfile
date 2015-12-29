requires 'strictures'       => 2.000000;
requires 'namespace::clean' => 0.24;
requires 'Moo'              => 2.000000;
requires 'Scalar::Util'     => 0;
requires 'Carp'             => 0;

on test => sub {
    requires 'Test::Stream' => 1.302026;
};
