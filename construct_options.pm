
# constructing variables that the HERE document will interpolate

use strict;
use warnings;

package construct_options;

sub get_options {
    my ( $type, $option ) = @_;
    my %hash    = ();
    my $options = q{};

    if ( $type eq 'dropdown' ) {
        if ( $option eq 'assignment' ) {
            %hash = (
                cruise_1 => 'Cruise_1',
                cruise_2 => 'Cruise_2',
                cruise_3 => 'Cruise_3',
            );
        }
        elsif ( $option eq 'xyz' ) {
            %hash = (
                fine   => 'fine',
                medium => 'medium',
                coarse => 'coarse',
            );
        }

        for my $p ( sort keys %hash ) {
            $options .= sprintf qq(\t<option value="%s">%s</option>\n),
              $hash{$p}, $p;
        }
    }
    elsif ( $type eq 'checkbox' ) {
        if ( $option eq 'biotic' ) {
            %hash = (
                trout       => 'trout',
                little_fish => 'little_fish',
                mermaid     => 'mermaid',
            );
        }
        elsif ( $option eq 'bottom_type' ) {
            %hash = (
				sand			=> 'sand',
				shellhashfine	=> 'shell_hash_fine',
                sand_ripples 	=> 'sand ripples',
                sand_waves   	=> 'sand waves',
                gravel       	=> 'gravel',
                cobble       	=> 'cobble',
            );
        }
        elsif ( $option eq 'sediment' ) {
            %hash = (
                fine   => 'fine',
                medium => 'medium',
                coarse => 'coarse',
                none   => 'none',
            );
        }

        foreach my $p ( sort keys %hash ) {

            # print "constructing string for $p and $hash{$p}\n";
            $options .=
              sprintf qq(<br><label><input type="checkbox" name="%s" value="%s">$p</label>\n),
              $option, $p;
			  
			  # <label for="percent">Cobble Percent: </label><input id="percent" type="number" name="cobble_percent" min="5" max="100" step="10" value ="5"/>
        }
    }

    return ($options);
}
1;
