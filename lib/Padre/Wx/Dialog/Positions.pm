package Padre::Wx::Dialog::Positions;

use 5.008;
use strict;
use warnings;
use Padre::DB         ();
use Padre::Wx         ();
use Padre::Wx::Dialog ();

our $VERSION = '0.71';

my @positions;

=head1 NAME

Go to previous (or earlier) position

=head1 DESCRIPTION

Remember position before certain movements 
and allow the user to jump to the earlier 
positions and then maybe back to the newer ones.

The location that will be remember are
the location before and after non-simple 
movements, for example:

=over 4

=item *

before/after jump to function declaration

=item *

before/after jump to variable declaration

=item *

before/after goto line number

=item *

before/after goto search result

=back

=cut

# TO DO Look for page_history and see if this can be united
# also the Bookmarks are similar a bit

# TO DO add keyboard short-cut ?
# TO DO add item next to buttons under the menues
# TO DO allow the display of all the items and jumping to any of the items
# TO DO reset the rest of the history when someone moves forward from the middle
#    A, B, C,  -> goto(B), D  then the history should be A, B, D   I think.


# a lot copied from Padre::Wx::Dialog::Bookmarks::set_position
sub set_position {
	my $class = shift;

	my $main    = Padre::Current->main;
	my $current = $main->current;
	my $editor  = $current->editor or return;
	my $path    = $current->filename;
	return unless defined $path;

	# TO DO Cannot (yet) set position in unsaved document

	my $line   = $editor->GetCurrentLine;
	my $file   = File::Basename::basename( $path || '' );
	my ($name) = $editor->GetLine($line);
	$name =~ s/\r?\n?$//;

	push @positions,
		{
		name => $name,
		file => $path,
		line => $line,
		};

	#print Data::Dumper::Dumper \@positions;
	return;
}

sub goto_prev_position {
	my $class = shift;
	my $main  = shift;

	return if not @positions;
	$class->goto_position( $main, scalar(@positions) - 1 );
	return;
}

sub goto_position {
	my $class = shift;
	my $main  = shift;
	my $pos   = shift;

	return if not defined $pos or $pos !~ /^\d+$/;
	return if not defined $positions[$pos];

	# $main->error( "" );

	# Is the file already open
	my $file   = $positions[$pos]{file};
	my $line   = $positions[$pos]{line};
	my $pageid = $main->find_editor_of_file($file);

	unless ( defined $pageid ) {

		# Load the file
		if ( -e $file ) {
			$main->setup_editor($file);
			$pageid = $main->find_editor_of_file($file);
		}
	}

	# Go to the relevant editor and row
	if ( defined $pageid ) {
		$main->on_nth_pane($pageid);
		my $page = $main->notebook->GetPage($pageid);
		$page->goto_line_centerize($line);
	}

	return;
}


1;

# Copyright 2008-2010 The Padre development team as listed in Padre.pm.
# LICENSE
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl 5 itself.
