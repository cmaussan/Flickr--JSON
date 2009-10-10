#!/usr/bin/perl

use strict;
use warnings;

use Flickr::JSON;
use YAML::XS;

my $flickr = Flickr::JSON->new(
    api_key => '34992826dcfda574e5befb5bb001c3a8',
);

my $data = $flickr->method( 'flickr.photosets.getList' => {
    user_id => '42841801@N02',
} );

print Dump( $data );

print "yeah!\n";
