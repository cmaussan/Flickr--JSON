use inc::Module::Install;
name 'Flickr-JSON';
all_from 'lib/Flickr/JSON.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
