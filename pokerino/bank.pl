use strict;
use warnings;

our %configuration;

# Variable Type is two chars.
# The first char:
#  R for raw integrated variables
#  D for dgt integrated variables
#  S for raw step by step variables
#  M for digitized multi-hit variables
#  V for voltage(time) variables
#
# The second char:
# i for integers
# d for doubles

# The ft banks id are:
#
# Tracker (trk):
# Tracker (hodo):
# Tracker (cal):

sub define_poker_bank
{


    my $bankId   = 400;
    my $bankname = "poker_crs";
    
    insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
    insert_bank_variable(\%configuration, $bankname, "sector",       1, "Di", "sector number");
    insert_bank_variable(\%configuration, $bankname, "xch",          2, "Di", "xch number");
    insert_bank_variable(\%configuration, $bankname, "ych",          3, "Di", "ych number");
    insert_bank_variable(\%configuration, $bankname, "zch",          4, "Di", "zch number");
    insert_bank_variable(\%configuration, $bankname, "pe_noS",       5, "Di", "pe_noS");
    insert_bank_variable(\%configuration, $bankname, "pe_S",         6, "Di", "pe_S");
    insert_bank_variable(\%configuration, $bankname, "dene",         7, "Dd", "dene");
    insert_bank_variable(\%configuration, $bankname, "Ampl_noS",     8, "Di", "Ampl_noS");
    insert_bank_variable(\%configuration, $bankname, "Ampl_S",       9, "Di", "Ampl_S");
    insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number"); 

    $bankId   = 500;
    $bankname = "poker_scint";
    
    insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
    insert_bank_variable(\%configuration, $bankname, "sector",       1, "Di", "sector number");
    insert_bank_variable(\%configuration, $bankname, "channel",      3, "Di", "channel number");
    insert_bank_variable(\%configuration, $bankname, "dene",         4, "Dd", "dene");
    insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number");

}



sub define_banks
{
	define_poker_bank();
}

1;










