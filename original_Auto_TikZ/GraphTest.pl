#!/bin/perl

use strict;
use warnings;

use lib "./";
use TikZ_Graph;

my $drawing = TikZ_Graph->new(-5,5,-5,5);
$drawing->addFunction("3*(x^2)-x");
$drawing->render();
