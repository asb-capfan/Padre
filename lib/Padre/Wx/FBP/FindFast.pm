package Padre::Wx::FBP::FindFast;

## no critic

# This module was generated by Padre::Plugin::FormBuilder::Perl.
# To change this module edit the original .fbp file and regenerate.
# DO NOT MODIFY THIS FILE BY HAND!

use 5.008005;
use utf8;
use strict;
use warnings;
use Padre::Wx ();
use Padre::Wx::Role::Main ();
use File::ShareDir ();

our $VERSION = '0.93';
our @ISA     = qw{
	Padre::Wx::Role::Main
	Wx::Panel
};

sub new {
	my $class  = shift;
	my $parent = shift;

	my $self = $class->SUPER::new(
		$parent,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::NO_BORDER | Wx::TAB_TRAVERSAL,
	);

	$self->{cancel} = Wx::BitmapButton->new(
		$self,
		Wx::ID_CANCEL,
		Wx::Bitmap->new( File::ShareDir::dist_file( "Padre", "icons/padre/16x16/actions/x-document-close.png" ), Wx::BITMAP_TYPE_ANY ),
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::NO_BORDER,
	);

	$self->{find_label} = Wx::StaticText->new(
		$self,
		-1,
		Wx::gettext("Find:"),
	);

	$self->{find_term} = Wx::TextCtrl->new(
		$self,
		-1,
		"",
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::TE_NO_VSCROLL,
	);

	Wx::Event::EVT_TEXT(
		$self,
		$self->{find_term},
		sub {
			shift->find_text_changed(@_);
		},
	);

	$self->{find_previous} = Wx::Button->new(
		$self,
		-1,
		Wx::gettext("&Previous"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{find_previous},
		sub {
			shift->find_previous_clicked(@_);
		},
	);

	$self->{find_next} = Wx::Button->new(
		$self,
		-1,
		Wx::gettext("&Next"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);
	$self->{find_next}->SetDefault;

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{find_next},
		sub {
			shift->find_next_clicked(@_);
		},
	);

	my $bSizer79 = Wx::BoxSizer->new(Wx::HORIZONTAL);
	$bSizer79->Add( $self->{cancel}, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALIGN_LEFT | Wx::ALL, 5 );
	$bSizer79->Add( 0, 0, 0, Wx::ALL | Wx::EXPAND, 5 );
	$bSizer79->Add( $self->{find_label}, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$bSizer79->Add( $self->{find_term}, 1, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$bSizer79->Add( $self->{find_previous}, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$bSizer79->Add( $self->{find_next}, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$bSizer79->Add( 0, 0, 0, Wx::ALL | Wx::EXPAND, 5 );

	$self->SetSizerAndFit($bSizer79);
	$self->Layout;

	return $self;
}

sub find_term {
	$_[0]->{find_term};
}

sub find_previous {
	$_[0]->{find_previous};
}

sub find_next {
	$_[0]->{find_next};
}

sub find_text_changed {
	$_[0]->main->error('Handler method find_text_changed for event find_term.OnText not implemented');
}

sub find_previous_clicked {
	$_[0]->main->error('Handler method find_previous_clicked for event find_previous.OnButtonClick not implemented');
}

sub find_next_clicked {
	$_[0]->main->error('Handler method find_next_clicked for event find_next.OnButtonClick not implemented');
}

1;

# Copyright 2008-2011 The Padre development team as listed in Padre.pm.
# LICENSE
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl 5 itself.

