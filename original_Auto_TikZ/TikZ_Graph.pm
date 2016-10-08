#!/bin/perl

#This is a Perl Module which automates and simplifies the process of generating
# simple graphs using PGFPlots, and then converting them into a Web-useable 
# format.
# MV; March 2014

use strict;
use warnings;

package TikZ_Graph;

#Paramter Order: xmin, xmax, ymin, ymax
sub new {
	my $class = shift;
	my $x1 = shift;
	my $x2 = shift;
	my $y1 = shift;
	my $y2 = shift;
	my $tex = "";
	my $axes = { xmin => $x1,
		     xmax => $x2,
		     ymin => $y1,
		     ymax => $y2, 
		     code => $tex, };
	return bless $axes, $class;
}

# Graphs a function on the axes definded in the constructor
#The function should be a string (Ie: "3*(x^4)-15*x^(-1)")
sub addFunction {
	my $self = shift;
	my $function = shift;
	$self->{code} .= "\t\\addplot[black]{$function};\n";
}

sub writeHeader {
	my $self = shift;
	print OUT "\\documentclass{standalone}\n\\usepackage{pgfplots}\n";
	print OUT "\\pgfplotsset{compat=1.4}\n"; #change compat value as needed
	print OUT "\\begin{document}\n\\begin{tikzpicture}\n\\begin{axis}[";
	print OUT " xmin=$self->{xmin}, xmax=$self->{xmax},";
	print OUT " ymin=$self->{ymin}, ymax=$self->{ymax},]\n";
}

sub writeFooter {
	print OUT "\\end{axis}\n\\end{tikzpicture}\n\\end{document}";
}

sub render {
	my $self = shift;
	my $fh = open OUT, ">/tmp/img.tex";
	$self->writeHeader();
	print OUT $self->{code};
	$self->writeFooter();
	close OUT;
	
	system "pdflatex /tmp/img.tex";
	system "convert img.pdf img.png";
	
    system "rm -f *.aux *.log *.pdf";
    #print HTML $self->include();
}

sub include {
	my $html = qq|<img src=img.png alt="PGF Graph"|;
	return $html; 
}
1;
