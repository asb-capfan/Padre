use strict;
use warnings;

use Test::More;
use FindBin;
plan skip_all => 'Test::Perl::Critic required to criticise code' if not eval "use Test::Perl::Critic (-profile => '$FindBin::Bin/critic.ini') ; 1";
all_critic_ok('blib/lib/Padre', glob('t/*.t'), 't/win32/', 't/author_tests/', 't/lib' ); # need to skip t/files and t/collection

