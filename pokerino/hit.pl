
use strict;
use warnings;

our %configuration;
our %parameters;


sub define_hit
{
	# uploading the hit definition
	my %hit = init_hit();
    $hit{"name"}            = "poker_crs";
    $hit{"description"}     = "Poker crystals";
    $hit{"identifiers"}     = "sector xch ych zch";
    $hit{"signalThreshold"} = "200.0*KeV";
    $hit{"timeWindow"}      = "1000*ns";
    $hit{"prodThreshold"}   = "10*um";
    $hit{"maxStep"}         = "1*mm";
    $hit{"delay"}           = "10*ns";
    $hit{"riseTime"}        = "1*ns";
    $hit{"fallTime"}        = "1*ns";
    $hit{"mvToMeV"}         = 100;
    $hit{"pedestal"}        = -20;
    print_hit(\%configuration, \%hit);
    
    
    %hit = init_hit();
    $hit{"name"}            = "poker_hcal";
    $hit{"description"}     = "Pokerino hcal";
    $hit{"identifiers"}     = "sector channel";
    $hit{"signalThreshold"} = "200.0*KeV";
    $hit{"timeWindow"}      = "1000*ns";
    $hit{"prodThreshold"}   = "10*um";
    $hit{"maxStep"}         = "1*mm";
    $hit{"delay"}           = "10*ns";
    $hit{"riseTime"}        = "1*ns";
    $hit{"fallTime"}        = "1*ns";
    $hit{"mvToMeV"}         = 100;
    $hit{"pedestal"}        = -20;
    print_hit(\%configuration, \%hit);

}


sub define_poker_hits
{
	define_hit();
}


1;
