#!/bin/perl

#This is a Perl Module which simplifies and automates the process of generating
# simple images using TikZ, and converting them into a Web-Useable format
# MV; March 2014

use strict; 
use warnings;

package TikZ_Image;

#The constructor is meant to be called with no parameters
sub new {
	my $class = shift;
	my $tex=();
	my $options = shift;
	my $obj = {code=>$tex, opt=>$options};
	return bless $obj, $class;
}

# Insert your TikZ image code, not including begin and end tags, as a single
# string parameter for this method. Works best single quoted.
sub addTex {
	my $self= shift;
	$self->{code} .= shift;
}


sub header {
my $self = shift;
	print OUT "\\documentclass{standalone}\n";
	print OUT "\\usepackage{tikz}\n";
	print OUT "\\begin{document}\n";
	print OUT "\\begin{tikzpicture}[".$self->{options}."]\n";
}

sub footer {
	print OUT "\\end{tikzpicture}\n\\end{document}";
}

# Call this method in the location where you want to generate your HTML code
# OR, comment out print HTML $self->include() and use it when your image is 
# complete
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
#here I'm assuming there's some file open which generates the HTML code for the
# problem and its page, so render() should be called in the problem text portion
# of a PG file.
	#print HTML $self->include();
}

#Separating out the html so as not to get confused
sub include {
	my $html= qq|<img src=img.png alt="TikZ Image">|;
	return $html;
}
1;
