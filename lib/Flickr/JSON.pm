package Flickr::JSON;

our $VERSION = '0.0.1';

use Moose;

use Text::Trim;
use JSON::XS;
with 'MooseX::UserAgent';

has 'useragent_conf' => (
    isa      => 'HashRef',
    is       => 'ro',
    required => 1,
    default  => sub { { 
        name => __PACKAGE__ . ' v.' . $VERSION, 
    }; },
);

has 'api_key' => (
    isa      => 'Str',
    is       => 'rw',
    required => 1,
);

sub method {
    my ( $self, $method, $args ) = @_;

    my $url = $self->url( $method => $args );

    my $response = $self->fetch( $url );
    my $result   = undef;
    
    if( $response->is_success ) {
        my $content = $self->get_content( $response );
        $content = trim $content;
        $content =~ /^jsonFlickrApi\((.+)\)$/;
        $result = decode_json $1;
    }
    else {
        $result = { error => $response->code };
    }
    $result;
}

sub url {
    my ( $self, $method, $args ) = @_;

    my %params = (
        method  => $method,
        api_key => $self->api_key,
        format  => 'json',
        %$args,
    );

    'http://api.flickr.com/services/rest/?' 
        . join( '&', map { $_ . '=' . $params{ $_ } } keys %params );    
}

1;
__END__

=head1 NAME

Flickr::JSON -

=head1 SYNOPSIS

  use Flickr::JSON;

=head1 DESCRIPTION

Flickr::JSON is

=head1 AUTHOR

Camille Maussang E<lt>camille.maussang@rtgi.frE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
