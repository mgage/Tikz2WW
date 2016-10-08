#!/bin/perl

use strict;
use warnings;

use lib "./";
use TikZ_FBD;

my $FBD = TikZ_FBD->new(15);
$FBD->addForce("Fa", 25, 3);
$FBD->addForce("Fg", eval(-90-$FBD->{plane}), 1);
$FBD->render();
