package pf::UnifiedApi::Controller::Users;

=head1 NAME

pf::UnifiedApi::Controller::User -

=cut

=head1 DESCRIPTION

pf::UnifiedApi::Controller::User

=cut

use strict;
use warnings;
use Mojo::Base 'pf::UnifiedApi::Controller::Crud';
use pf::dal::person;
use pf::dal::node;
use pf::person;
use pf::node;
use pf::constants qw($default_pid);

has dal => 'pf::dal::person';
has url_param_name => 'user_id';
has primary_key => 'pid';

sub unassign_nodes {
    my ($self) = @_;
    my $pid = $self->id;
    my $count = person_unassign_nodes($pid);
    if (!defined $count) {
        return $self->render_error(500, "Unable the unassign nodes for $pid");
    }

    return $self->render(status => 200, json => {status => "success", count => $count});
}

=head1 AUTHOR

Inverse inc. <info@inverse.ca>

=head1 COPYRIGHT

Copyright (C) 2005-2018 Inverse inc.

=head1 LICENSE

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
USA.

=cut

1;

