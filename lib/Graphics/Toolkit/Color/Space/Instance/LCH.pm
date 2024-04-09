use v5.12;
use warnings;

# CIE LCh(uv) linear color space specific code

package Graphics::Toolkit::Color::Space::Instance::LCH;
use Graphics::Toolkit::Color::Space;

my ($i_max, $q_max)   = (0.5959, 0.5227);
my ($i_size, $q_size) = (2 * $i_max, 2 * $q_max);

my  $hcl_def = Graphics::Toolkit::Color::Space->new( axis => [qw/hue croma luminance/],
                                                    range => [0.95047, 1, 1.08883] );

    $hcl_def->add_converter('RGB', \&to_rgb, \&from_rgb );

sub from_rgb {
    my ($r, $g, $b) = @_;
    my $y =           (0.299  * $r) + ( 0.587  * $g) + ( 0.114  * $b);
    my $i = ($i_max + (0.5959 * $r) + (-0.2746 * $g) + (-0.3213 * $b)) / $i_size;
    my $q = ($q_max + (0.2115 * $r) + (-0.5227 * $g) + ( 0.3112 * $b)) / $q_size;
    return ($y, $i, $q);
}


sub to_rgb {
    my ($y, $i, $q) = @_;
    $i = ($i * $i_size) - $i_max;
    $q = ($q * $q_size) - $q_max;
    my $r = $y + ( 0.956 * $i) + ( 0.619 * $q);
    my $g = $y + (-0.272 * $i) + (-0.647 * $q);
    my $b = $y + (-1.106 * $i) + ( 1.703 * $q);
    return ($r, $g, $b);
}

$hcl_def;

# 0,95047
# 1
# 1,08883
