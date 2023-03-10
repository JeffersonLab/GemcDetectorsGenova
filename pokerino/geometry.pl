use strict;
use warnings;

our %configuration;


my $degrad = 0.01745329252;
my $cic    = 2.54;


my $BDXmini_externalBox_X = 100;
my $BDXmini_externalBox_Y = 100;
my $BDXmini_externalBox_Z = 100;



sub make_poker_main_volume
    {
     my %detector = init_det();
 
    $detector{"name"}        = "main_volume";
    $detector{"mother"}      = "root";
    $detector{"description"} = "World";
    $detector{"color"}       = "666666";
    $detector{"style"}       = 0;
    $detector{"visible"}     = 1;
    $detector{"type"}        = "Box";
    
    my $X = 0.;
    my $Y = 0.;
    my $Z = 0.;
    $detector{"pos"}         = "$X*cm $Y*cm $Z*cm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    
    my $par1 = 150.;
    my $par2 = 150.;
    my $par3 = 150.;

    $detector{"dimensions"}  = "$par1*cm $par2*cm $par3*cm";
    $detector{"material"}    = "G4_Galactic";
    print_det(\%configuration, \%detector);
}


sub make_ecal
{
    my %detector = init_det();
    my $Nx = 3;                          # Number of crystals in horizontal directions
    my $Ny = 3;                          # Number of crystals in vertical directions
    my $detPWO_Width = 20.;               # Crystal width in mm
    my $detPWO_Thickness = 250.;          # Crystal lenght in mm
    my $Wrapping =0;                      # Thickness of the wrapping
    my $AGap =0.5;                          # Air Gap between Crystals
    my $Tot_width  = $detPWO_Width+$Wrapping+$AGap;  # Width of the crystal mother volume, total width of crystal including wrapping and air gap
    my $Tot_thickness =$detPWO_Thickness + $Wrapping; # Thickness of the crystal mother volume, total lenght of crystal including wrapping
 
    my $centX = ($Nx/2 )+0.5;
    my $centY = ($Ny/2 )+0.5;
    my $centZ = 0.;
    my $y_C =0;
    my $x_C =0;
    my $z_C=0;
    my $dx=0;
    my $dy=0;
    my $dz=0;
    my $iZ=0;
    

        
    #ECAL
    $iZ =4;
    for(my $iX=1; $iX<=$Nx; $iX++)
    {
        
    for (my $iY=1; $iY<=$Ny; $iY++){

        $x_C  =($iX-$centX)*$Tot_width;
        $y_C = ($iY-$centY)*$Tot_width;
        $z_C  = 0.;
        
        $detector{"name"}        = "Crs_volume"."_"."$iX"."_"."$iY"."_"."$iZ";
        $detector{"mother"}      = "main_volume";
        $detector{"description"} = "PbWO4 crystal mother volume "."$iX"."$iY"."$iZ";
        $detector{"color"}       = "838EDE";
        $detector{"style"}       = 0;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $detector{"pos"}         = "$x_C*mm $y_C*mm $z_C*mm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $dx =$Tot_width/2 ;
        $dy =$Tot_width/2 ;
        $dz =$Tot_thickness/2 ;
        $detector{"dimensions"}  = "$dx*mm $dy*mm $dz*mm";
        $detector{"material"}    = "G4_Galactic";
        print_det(\%configuration, \%detector);
        
        $detector{"name"}        = "Crs"."_"."$iX"."_"."$iY"."_"."$iZ";
        $detector{"mother"}      = "Crs_volume"."_"."$iX"."_"."$iY"."_"."$iZ";
        $detector{"description"} = "PbWO4 crystal "."$iX"."$iY"."$iZ";
        $detector{"color"}       = "1c86ea";
        $detector{"style"}       = 1;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $x_C=0;
        $y_C=0;
        $z_C=0;
        $detector{"pos"}         = "$x_C*mm $y_C*mm $z_C*mm";
        $detector{"rotation"}    = "0*deg 0*deg 0*deg";
        $dx =$detPWO_Width/2 ;
        $dy =$detPWO_Width/2 ;
        $dz =$detPWO_Thickness/2 ;
        $detector{"dimensions"}  = "$dx*mm $dy*mm $dz*mm";
        $detector{"material"}    = "G4_PbWO4";
        $detector{"sensitivity"} = "poker_crs";
        $detector{"hit_type"}    = "poker_crs";
         my $man=400;
        $detector{"identifiers"} = "sector manual $man xch manual $iX ych manual $iY zch manual $iZ ";
        print_det(\%configuration, \%detector);
        
        
    }
    }
}

sub make_HCAL{
    
    my %detector = init_det();
    my $Nz = 18;                          # Number of crystals in horizontal directions
    my $Layer_X = 200.;                   # Layer X dimension  in mm
    my $Layer_Y = 200.;                   # Layer X dimension  in mm
    my @LayerFe_Thickness = (20.,20.,20.,20.,20.,20.,20.,20.,20.);          # Fe Thickness in mm. It is referred to the first layer
    my @LayerSc_Thickness = (20.,20.,20.,20.,20.,20.,20.,20.,20.);          # Plastic scintillator Thickness in mm
    my $Wrapping =0;                      # Thickness of the wrapping
    my $AGap =0.5;                          # Air Gap between Crystals
    
    my $centX = 0.;
    my $centY = 0.0;
    my $centZ = 500. + 125.;
    my $y_C =0;
    my $x_C =0;
    my $z_C=0;
    my $dx=0;
    my $dy=0;
    my $dz=0;
    my $iZ=0;
    my $Layer_Fe =0;
    my $Layer_Sc =0;
    
    
    for(my $iZ=1; $iZ<=$Nz; $iZ++)
    {
        if($iZ%2!=0){
            $Layer_Fe = $Layer_Fe + $LayerFe_Thickness[0.5*($iZ-1)]/2;
            if($iZ!=1) {$Layer_Sc = $Layer_Sc + $LayerSc_Thickness[0.5*($iZ-1)-1]/2;
            }
        }
        if($iZ%2==0) {
            $Layer_Sc = $Layer_Sc + $LayerSc_Thickness[0.5*$iZ-1]/2;
            $Layer_Fe = $Layer_Fe + $LayerFe_Thickness[0.5*($iZ-2)]/2;
        
            }

        $z_C = $centZ + $Layer_Fe + $Layer_Sc;
        $x_C  =0.;
        $y_C = 0;
    
        
        if($iZ%2!=0){
        $detector{"name"}        = "HCAL_volume"."_"."$iZ";
        $detector{"mother"}      = "main_volume";
        $detector{"description"} = "Layer Fe "."$iZ";
        $detector{"color"}       = "f00a28";
        $detector{"style"}       = 1;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $detector{"pos"}         = "$x_C*mm $y_C*mm $z_C*mm";
        $dx =$Layer_X/2 ;
        $dy =$Layer_Y/2 ;
        $dz =$LayerFe_Thickness[0.5*($iZ-1)]/2 ;
        $detector{"dimensions"}  = "$dx*mm $dy*mm $dz*mm";
        $detector{"material"}    = "G4_Fe";
        print_det(\%configuration, \%detector);
        }
        
        if($iZ%2==0){
        $detector{"name"}        = "HCAL_volume"."_"."$iZ";
        $detector{"mother"}      = "main_volume";
        $detector{"description"} = "Layer Sc "."$iZ";
        $detector{"color"}       = "210af0";
        $detector{"style"}       = 1;
        $detector{"visible"}     = 1;
        $detector{"type"}        = "Box";
        $detector{"pos"}         = "$x_C*mm $y_C*mm $z_C*mm";
        $dx =$Layer_X/2 ;
        $dy =$Layer_Y/2 ;
        $dz =$LayerSc_Thickness[0.5*$iZ-1]/2 ;
        $detector{"dimensions"}  = "$dx*mm $dy*mm $dz*mm";
        $detector{"material"}    = "scintillator";
        $detector{"sensitivity"} = "poker_hcal";
        $detector{"hit_type"}    = "poker_hcal";
             my $man=500;
        $detector{"identifiers"} = "sector manual $man channel manual $iZ ";
        print_det(\%configuration, \%detector);
        }

        
    }
    
}



sub make_poker
{
    make_ecal();
    make_HCAL();
    make_poker_main_volume();
}




1;

