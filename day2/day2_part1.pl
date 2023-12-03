#!/usr/bin/perl

# Modules
use strict;
use warnings; # Only for Debugging

sub main {
    my $total = 0;
    my @wins = grab_wins();
    foreach(@wins) {
        $total += $_;
    }
    print($total . "\n");
}

sub grab_wins {
    # print(@colors_array[2]);
    my @wins;
    my $line_counter = 0;
    my $filename = 'input.txt';
    open(my $fh, '<', $filename) or die "File '$filename' can't be opened";
    while(<$fh>) {
        chomp;
        $_ =~ s/^[^:]*://;
        # print($_ . "\n");
        my @games = split(/;/, $_);
        # print($_ . "\n");  
        # print("\n\nNext loop:\n" . join("\n", @games));
        my $game_valid = 1;
        foreach (@games) {
            # print($_);
            my $game = $_;
            # print("\n\nIn games loop: " . $game);
            my @colors = split(/,/, $game);
            my $color_counter = 0;
            foreach(@colors) {
                my $limit = 0;
                if ($_ =~ m/red/g) {
                    $limit = 12;
                } elsif ($_ =~ m/green/g) {
                    $limit = 13;
                } elsif ($_ =~ m/blue/g) {
                    $limit = 14;
                } else {
                    print("error in color ID regex");
                }
                $_ =~ s/[^0-9]//g;
                # print("\nThe number drawn " . $_ . "\n");
                if ($_ > $limit) {
                    $game_valid = 0;
                }
                $color_counter++;
            }
            # print("\nGame result: " . $game_valid);
        }
        # print($line_counter);
        if($game_valid) {
            push(@wins, $line_counter + 1);
        }
        $line_counter++;
    }
    return(@wins);
}

main();