: /%NEXTERNS $4 ; \ 4
: /%NSEL_BITS $5 ; \ 5
: /%NSEL_MAX $1f ; \ (1 << NSEL_BITS)-1
: // $0 ;
: //_ID // $400 + ;
: //_VER // $401 + ;
$89bd20d0 constant //_ID_VAL 
$72acd6cd constant //_VER_VAL 
: //_CR1 // $402 + ;
: //_CTRL // $403 + ;
: //_CTRL.CLK_ENABLE //_CTRL $1f $0 ;
: //_CTRL.CLK_FREQ //_CTRL $1e0 $5 ;
: //_CTRL.PLL_RESET //_CTRL $200 $9 ;
: //_CR2 // $404 + ;
: //#TEST_OUT // + $405 + ;
: //#TEST_IN // + $408 + ;
: //#LINKS // $ee00 + swap $10 * + ;
: //#LINKS_ID //#LINKS $0 + ;
: //#LINKS_VER //#LINKS $1 + ;
$5bd964c2 constant //#LINKS_ID_VAL 
$ad9541a4 constant //#LINKS_VER_VAL 
: //#LINKS_CTRL //#LINKS $2 + ;
: //#LINKS_CTRL.START //#LINKS_CTRL $1 $0 ;
: //#LINKS_CTRL.SPEED //#LINKS_CTRL $1e $1 ;
: //#LINKS_CTRL.STOP //#LINKS_CTRL $20 $5 ;
: //#LINKS#Test1 //#LINKS + $3 + ;
: //#LINKS#Test1.FIELD1 //#LINKS#Test1 $1 $0 ;
: //#LINKS#Test1.FIELD2 //#LINKS#Test1 $1e $1 ;
: //#LINKS#Test1.FIELD3 //#LINKS#Test1 $20 $5 ;
: //#LINKS_STATUS //#LINKS $4 + ;
: //#LINKS#ENABLEs //#LINKS + $5 + ;
: //#EXTERN // $f000 + swap $400 * + ;
: //_EXTHUGE // $10000 + ;
