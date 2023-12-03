#!/usr/bin/perl

# Modules
use strict;
use warnings; # Only for Debugging

sub main {
    my $total = 0;
    my @powers = grab_powers();
    foreach(@powers) {
        $total += $_;
    }
    print("The sum of the powers is: " . $total . "\n");
}

sub grab_powers {
    # print(@colors_array[2]);
    my @powers;
    my $filename = 'input.txt';
    open(my $fh, '<', $filename) or die "File '$filename' can't be opened";
    while(<$fh>) {
        chomp;
        $_ =~ s/^[^:]*://;
        # print($_ . "\n");
        my @games = split(/;/, $_);
        # print($_ . "\n");  
        # print("\n\nNext loop:\n" . join("\n", @games));
        my @color_maxes = (0,0,0);
        foreach (@games) {
            # print($_);
            my $game = $_;
            # print("\n\nIn games loop: " . $game);
            my @color_indices;
            push(@color_indices, index($game, 'red'));
            push(@color_indices, index($game, 'blue'));
            push(@color_indices, index($game, 'green'));
            my $color_counter = 0;
            foreach (@color_indices) {
                my $current_value = 0;
                if($_ != -1) {
                    # print("\ntest:" . $color_counter . " " . substr($game, $_-3, 5) . " and game:" . $game);
                    if(substr($game, $_-3, 1) =~ /\d/) {
                        $current_value = substr($game, $_-3, 2);
                    } else {
                        $current_value = substr($game, $_-2, 1);
                    }
                    # print("\ncolor maxes: " . join(", ", @color_maxes));
                    # print("\ncurrent value: " . $current_value);
                }
                if ($current_value > @color_maxes[$color_counter]) {
                    @color_maxes[$color_counter] = $current_value;
                }
                $color_counter++;
            }
        }
        # print("\n\nColor maxes:\n" . join("\n", @color_maxes));
        push(@powers, @color_maxes[0]*@color_maxes[1]*@color_maxes[2]);
    }
    return(@powers);
}

main();