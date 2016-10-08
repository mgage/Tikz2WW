#!/bin/perl

#This is a Perl Module which automates and simplifies the process of generating
# simple Free Body Diagrams using TikZ, and converting them into 
# Web-useable form
# MV; March 2014

package TikZ_FBD;

use strict; 
use warnings;

sub new {
	my $class = shift;
	my $TikZ;
	my $arg;
	if (! undef $_){ $arg = shift;} else{ $arg = 0;}
	my $obj = {code => $TikZ,
		   plane => $arg,
	};	
	return bless $obj, $class;
}

sub addForce {
	my $self = shift;
	my $label = shift;
	my $angle = shift;
	my $magnitude = shift;
	$self->{code} .= "\\draw (0,0) -- ($angle:$magnitude )  node[above] {\$$label\$};";
}

sub header {
	my $self = shift;
	print OUT "\\documentclass{standalone}\n";
	print OUT "\\usepackage{tikz}\n";
	print OUT "\\begin{document}\n";
	print OUT "\\begin{tikzpicture}\n";
	
	print OUT "\\begin{scope}[rotate=".$self->{plane}."]\n";
	print OUT "\\filldraw[black!50!white, draw=black] (-1,-1) rectangle(1,1);\n";
}

sub footer {
	print OUT "\\end{scope}\n";
	print OUT "\\end{tikzpicture}\n";
	print OUT "\\end{document}";
}

sub render {
	my $self = shift;
	
	open OUT, ">/tmp/img.tex";
	$self->header();
	print OUT $self->{code}."\n";
	$self->footer();
	close OUT;
	
	system "pdflatex /tmp/img.tex";
	system "convert img.pdf img.png";
	
	system "rm -f *.aux *.log *.pdf";
	#print HTML $self->include();
}

#Separating out the html so as not to get confused
sub include {
	my $html= qq|<img src=/tmp/img.png alt="TikZ Image">|;
	return $html;
}
1;
