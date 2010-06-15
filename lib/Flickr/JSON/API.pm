package Flickr::JSON::API;

use Flickr::JSON;
use Moose;

has 'context' => (
    isa      => 'HashRef',
    is       => 'ro',
    required => 1,
);

has 'client' => (
    isa      => 'Flickr::JSON',
    is       => 'ro',
    required => 1,
    lazy     => 1,
    default  => sub {
        my $flickr = shift->context->{ flickr }
            or die 'flickr missing in context';

        Flickr::JSON->new( %$flickr );        
    },
);

# photos
# photosets

sub photosets_get_list {
    my $self = shift;
    
    my $data = $self->client->method( 'flickr.photosets.getList' => {
        user_id => $self->context->{ flickr }->{ user_id },
    } );

    my $sets = [];

    if( $data->{ stat } eq 'ok' ) {
        $sets = $data->{ photosets }->{ photoset };
    }

    $sets;
}

sub photosets_get_photos {
    my ( $self, $id, $other ) = @_;

    my $data = $self->client->method( 'flickr.photosets.getPhotos' => {
            photoset_id => $id,
            %$other,
    } );

    my $photos = [];
    
    if( $data->{ stat } eq 'ok' ) {
        $photos = $data->{ photoset }->{ photo };
    }
    
    $photos;
}

1
