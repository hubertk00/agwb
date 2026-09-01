: /%NEXTERNS $4 ; \ 4
: /%NSEL_BITS $5 ; \ 5
: /%NSEL_MAX $1f ; \ (1 << NSEL_BITS)-1
: // $0 ;
: //_ID // $2000 + ;
: //_VER // $2001 + ;
: //_TSTDV_RW // $2004 + ;
: //_TSTDV_WO // $2005 + ;
: //_TSTDV_RO // $2006 + ;
: //_TSTDV_TOUT // $2007 + ;
$89bd20d0 constant //_ID_VAL 
$ce69ae7e constant //_VER_VAL 
: //_CTRL // $2008 + ;
: //_CTRL.CLK_ENABLE //_CTRL $1f $0 ;
: //_CTRL.CLK_FREQ //_CTRL $1e0 $5 ;
: //_CTRL.PLL_RESET //_CTRL $200 $9 ;
: //#TEST_OUT // + $2009 + ;
: //#TEST_IN // + $200c + ;
: //#LINKS // $ee00 + swap $10 * + ;
: //#LINKS_ID //#LINKS $0 + ;
: //#LINKS_VER //#LINKS $1 + ;
$5bd964c2 constant //#LINKS_ID_VAL 
$9f5e3c34 constant //#LINKS_VER_VAL 
: //#LINKS_CTRL //#LINKS $2 + ;
: //#LINKS_CTRL.START //#LINKS_CTRL $1 $0 ;
: //#LINKS_CTRL.STOP //#LINKS_CTRL $2 $1 ;
: //#LINKS_CTRL.SPEED //#LINKS_CTRL $3c $2 ;
: //#LINKS#X2 //#LINKS + $3 + ;
: //#LINKS#X2.B1 //#LINKS#X2 $1 $0 ;
: //#LINKS#X2.B2 //#LINKS#X2 $2 $1 ;
: //#LINKS#X2.B3 //#LINKS#X2 $4 $2 ;
: //#LINKS#ENABLEs //#LINKS + $4 + ;
: //#LINKS_STATUS //#LINKS $e + ;
: //#EXTERN // $f000 + swap $400 * + ;
: //_EXTHUGE // $10000 + ;
