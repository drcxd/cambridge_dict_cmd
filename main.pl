#!/bin/perl

use strict;
use warnings;
use 5.010;

my $URL = "https://dictionary.cambridge.org/dictionary/english/";
my $PATTERN = "<b class=\\\"def\\\">.*</b>";

# fist a single pass program
my $word = shift @ARGV;
my $request_url = "${URL}${word}";
my $cmd = "curl -s ${request_url} | grep \"${PATTERN}\"";
# say "cmd is $cmd";
my @result = `$cmd`;
for (@result) {
    my $line = $_;
    $line =~ s#\A.*<b class="def">##;
    $line =~ s#</b>.*\Z##;
    # print $line;
    while ($line =~ m/title="(\w+)">/)
    {
        my $link = $1;
        $line =~ s#<a.*?${link}</a>#${link}#;
        # print $line;
    }
    print $line;
}
