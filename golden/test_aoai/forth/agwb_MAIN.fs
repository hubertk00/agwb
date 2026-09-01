: /%NEXTERNS $4 ; \ 4
: /%NSEL_BITS $5 ; \ 5
: /%NSEL_MAX $1f ; \ (1 << NSEL_BITS)-1
: // $0 ;
: //_ID // $400 + ;
: //_VER // $401 + ;
$89bd20d0 constant //_ID_VAL 
$d5542343 constant //_VER_VAL 
: //_CR1 // $402 + ;
: //_CTRL // $403 + ;
: //_CTRL.CLK_ENABLE //_CTRL $1f $0 ;
: //_CTRL.CLK_FREQ //_CTRL $1e0 $5 ;
: //_CTRL.PLL_RESET //_CTRL $200 $9 ;
: //_CR2 // $404 + ;
: //#TEST_OUT // + $405 + ;
: //#TEST_IN // + $408 + ;
: //#LINKS // $ec00 + swap $20 * + ;
: //#LINKS_ID //#LINKS $0 + ;
: //#LINKS_VER //#LINKS $1 + ;
$5bd964c2 constant //#LINKS_ID_VAL 
$1f601bb6 constant //#LINKS_VER_VAL 
: //#LINKS_CTRL //#LINKS $2 + ;
: //#LINKS_CTRL.START //#LINKS_CTRL $1 $0 ;
: //#LINKS_CTRL.SPEED //#LINKS_CTRL $1e $1 ;
: //#LINKS_CTRL.STOP //#LINKS_CTRL $20 $5 ;
: //#LINKS_STATUS //#LINKS $3 + ;
: //#LINKS#RREG //#LINKS + $4 + ;
: //#LINKS#ENABLEs //#LINKS + $7 + ;
: //#EXTERN // $f000 + swap $400 * + ;
: //_EXTHUGE // $10000 + ;
