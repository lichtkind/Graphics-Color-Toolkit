#!/usr/bin/perl

use v5.12;
use warnings;
use Test::More tests => 20;
use Test::Warn;

BEGIN { unshift @INC, 'lib', '../lib'}
my $module = 'Graphics::Toolkit::Color::Util';

eval "use $module";
is( not($@), 1, 'could load the module');

my $round = \&Graphics::Toolkit::Color::Util::round;
is( $round->(0.5),           1,     'round 0.5 upward');
is( $round->(0.500000001),   1,     'everything above 0.5 gets also increased');
is( $round->(0.4999999),     0,     'everything below 0.5 gets smaller');
is( $round->(-0.5),         -1,     'round -0.5 downward');
is( $round->(-0.500000001), -1,     'everything beow -0.5 gets also lowered');
is( $round->(-0.4999999),    0,     'everything upward from -0.5 gets increased');

my $rmod = \&Graphics::Toolkit::Color::Util::rmod;

is( $rmod->(),               0,     'default to 0 when both values missing');
is( $rmod->(1),              0,     'default to 0 when a value is missing');
is( $rmod->(1,0),            0,     'default to 0 when a divisor is zero');
is( $rmod->(3, 2),           1,     'normal int mod');
is( $rmod->(2.1, 2),       0.1,     'real mod when dividend is geater');
is( $rmod->(.1, 2),        0.1,     'real mod when divisor is geater');
is( $rmod->(-3, 2),         -1,     'int mod with negative dividend');
is( $rmod->(-3.1, 2),     -1.1,     'real mod with negative dividend');
is( $rmod->(3, -2),          1,     'int mod with negative divisor');
is( $rmod->(3.1, -2),      1.1,     'real mod with negative divisor');
is( $rmod->(-3, -2),        -1,     'int mod with negative divisor');
is( $rmod->(-3.1, -2),    -1.1,     'int mod with negative divisor');
is( $rmod->(15.3, 4),      3.3,     'real mod with different values');


exit 0;
