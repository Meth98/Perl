#!/usr/bin/perl -w

# Bubble sort of an array

use strict;
use Term::ANSIColor;
use Scalar::Util qw(looks_like_number);

my @number = ();
my $flag = 0;
my $i;
my $j;
my $temp;
my $max = 0;
my $sum = 0;
my $cumulated = 0;

if (($#ARGV + 1) lt 2) {
        print "Warning!! You should put at least 2 elements!\n";
} else {
        for (@ARGV) {
                if (! looks_like_number($_)) {
                        $flag = 1;
                }
        }

        if ($flag) {
                print "Warning!! You should put only the numbers!\n";
        } else {
                @number = @ARGV;
                sleep 1;
                print color "green";
                print "\nUnordered list:";
                print color "reset";
                print " @number\n\n";
                sleep 1;
                print color "green";
                print "Ordered list:";
                print color "reset";

                for ($i = 0; $i <= $#number; $i++) {
                        for ($j = 0; $j <= $#number - 1; $j++) {
                                if ($number[$j] > $number[$j + 1]) {
                                        $temp = $number[$j];
                                        $number[$j] = $number[$j + 1];
                                        $number[$j + 1] = $temp
                                }
                        }
                }

                print " @number\n\n";
                sleep 1;
                print color "green";
                print "The largest number is:";
                print color "reset";

                for ($i = 0; $i <= $#number; $i++) {
                        if ($number[$i] > $max) {
                                $max = $number[$i];
                        }
                }

                print " $max\n\n";
                sleep 1;
                print color "green";
                print "The sum of all numbers is:";
                print color "reset";

                for ($j = 0; $j <= $#number; $j++) {
                        $sum = $sum + $number[$j];
                }

                print " $sum\n\n";
                print color "green";
                print "Cumulated:";
                print color "reset";

                foreach (@number) {
                        $cumulated = $cumulated + $_;
                        print " $cumulated";
                }
                
                print "\n\n";
        }
}