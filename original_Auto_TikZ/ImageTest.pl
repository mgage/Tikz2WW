#!/bin/perl

use strict;
use warnings;

use lib "./";
use TikZ_Image;

my $drawing = TikZ_Image->new("line width=33pt, scale=3");

$drawing->addTex("\\draw (0,0) rectangle(1,2);");
$drawing->render();
