use strict;
use warnings;

use List::MoreUtils qw(uniq);
use Web::Scraper;
use URI;

my $functions = scraper {
    process "div#content div.index a.function", 'functions[]' => sub {
        my $text = $_->as_text or return;
        return $text;
    };
    result 'functions';
}->scrape(URI->new('http://jp.php.net/manual/ja/indexes.php'));

map {
    s/\(\)$//;
    s/.*->(.*)$/$1/;
    s/.*::(.*)$/$1/;
} @$functions;

print join "\n", uniq @$functions;


