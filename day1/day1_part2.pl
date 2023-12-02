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
        print($_ . "\n");
        my $line = convert_letters_to_numbers($_);
        print($line . "\n");
        $line =~ s/[^0-9]//g;
        push(@numbers, substr($line, 0, 1) . substr($line, -1, 1));
        
    }
    return(@numbers);
}

# This is gonna get ugly. Every part of my being hated writing this.
# I tried this with regex, but it just outright refused to work properly.
sub convert_letters_to_numbers {
    my $line = @_[0];
    my @numbers_array = ('one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine');

    # That's right, nested loops. In a function that is called from a loop. So effectively
    # a triple nested loop. It's perl, you aren't exactly using it for speed anyways.
    for(my $i = 0; $i < 9; $i++) {
        my $number_index = index($line, @numbers_array[$i]);
        while ($number_index > -1) {
            substr($line, ($number_index + 1), (length(@numbers_array[$i]) - 2), ($i + 1));
            $number_index = index($line, @numbers_array[$i]);
        }
    }
    return $line;
}

main();