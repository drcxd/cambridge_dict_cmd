#!/bin/perl

use strict;
use warnings;
use 5.010;

my $URL = "https://dictionary.cambridge.org/dictionary/english/";
my $PATTERN = "<div class=\"def ddef_d db\">.*?</div>";
my $TEMP_FILE = "DICT_TEMP";

# fist a single pass program
# query(shift @ARGV);


# then a loop command-line interface
print "% ";
while (my $word = <STDIN>)
{
    chomp $word;
    query($word);
    print "% ";
}

sub query {
    my $word = shift @_;
    my $request_url = "${URL}${word}";
    # say "downloading...";
    `wget -q $request_url -O $TEMP_FILE`;
    # say "greping...";
    my $grepcmd = "grep -P \"<div class=\\\"def ddef_d db\\\">.*?</div>\" $TEMP_FILE";
    my @result = `$grepcmd`; # it's weird that the commad must run in a variable instead of unfold directly inside the ``
    my $grep_name_cmd = "grep \"og:url\" $TEMP_FILE";
    my $name = `$grep_name_cmd`;
    if ($name =~ m#english/(.*?)"#) {
        $name = $1;
        say $name;
    }

    for (@result) {
        my $line = $_;
        $line =~ s#\A.*<div class="def ddef_d db">##;
        $line =~ s#</div>.*\Z##;
        # print $line;
        while ($line =~ m/title="(\w+)">/)
        {
            my $link = $1;
            $line =~ s#<a.*?${link}</a>#${link}#;
            # print $line;
        }
        while ($line =~ m#<span.*?>(.*?)</span>#) {
            my $content = $1;
            $line =~ s#<span.*?>.*?</span>#$content#;
            # say $line;
        }
        print "# ";
        print $line;
    }
}
