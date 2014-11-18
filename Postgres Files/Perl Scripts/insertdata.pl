#!/usr/bin/perl -w
use strict;
 
print generate_random_string() . "\n" for 1 .. 10_000_000;
 
exit;
 
sub generate_random_string {
    my $word_count = 2 + int(rand() * 4);
    return join(' ', map { generate_random_word() } 1..$word_count);
}
 
sub generate_random_word {
    my $len = 3 + int(rand() * 5);
    my @chars = ( "a".."z", "A".."Z", "0".."9" );
    my @word_chars = map { $chars[rand @chars] } 1.. $len;
    return join '', @word_chars;
}
