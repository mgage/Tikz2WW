#!/bin/perl 

use strict;
use warnings;


use lib "./";
use TikZ_Image2;

my $working_dir = "DATA";
my $file_name    = "potato2";
my $dir = '/Users/mgage1/desktop';
my $destination_path = "/Users/mgage1/desktop/$file_name.png";

sub tikz_graph{
	my $drawing = TikZ_Image2->new();
	$drawing->{working_dir}=$working_dir;
	$drawing->{file_name}=$file_name;
	$drawing->{destination_path}= $destination_path;
	$drawing->set_commandline_mode("macbook"); # "wwtest" or "macbook"

	$drawing->addTex(shift);
	$drawing->render();
	return $drawing->{destination_path};
}

my $path = tikz_graph("\begin{tikzpicture}[main_node/.style={circle,fill=blue!20,draw,minimum size=1em,inner sep=3pt]}] 
\node[main_node] (1) at (0,0) {1}; 
 \node[main_node] (2) at (-1, -1.5)  {2};
  \node[main_node] (3) at (1, -1.5) {3}; 
  \draw (1) -- (2) -- (3) -- (1); 
   \end{tikzpicture}");
print "Open file created at $path\n";
system "open $path";
1;
