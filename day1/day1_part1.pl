#!/usr/bin/perl

# Modules
use strict;
#use warnings; # Only for Debugging

sub main {
    my $total = 0;
    my @numbers = grab_numbers();
    foreach(@numbers) {
        $total += $_;
    }
    print($total . "\n");
}

sub grab_numbers {
    my @numbers;
    my $filename = 'input.txt';
    open(my $fh, '<', $filename) or die "File '$filename' can't be opened";
    while(<$fh>) {
        chomp;
        $_ =~ s/[^0-9]//g;
        push(@numbers, substr($_, 0, 1) . substr($_, -1, 1));
        
    }
    return(@numbers);
}

main();