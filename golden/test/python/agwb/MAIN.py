"""
This file has been automatically generated
by the agwb (https://github.com/wzab/agwb).
Do not modify it by hand.
"""

from . import agwb


class HTEST(agwb.Block):
    x__is_blackbox = True
    x__size = 65536
    x__fields = {
        'reg':(0x0,65536,(agwb.ControlRegister,))
    }


class EXTTEST(agwb.Block):
    x__is_blackbox = True
    x__size = 1024
    x__fields = {
        'reg':(0x0,1024,(agwb.ControlRegister,))
    }


class SYS1(agwb.Block):
    x__size = 16
    x__id = 0x5bd964c2
    x__ver = 0x9f5e3c34
    x__fields = {
        'ID':(0x0,(agwb.StatusRegister,)),\
        'VER':(0x1,(agwb.StatusRegister,)),\
        'CTRL':(0x2,(agwb.ControlRegister,
        {\
            'START':agwb.BitField(0,0,False),\
            'STOP':agwb.BitField(1,1,False),\
            'SPEED':agwb.BitField(5,2,False),\
        })),
        'X2':(0x3,1,(agwb.ControlRegister,
        {\
            'B1':agwb.BitField(0,0,False),\
            'B2':agwb.BitField(1,1,False),\
            'B3':agwb.BitField(2,2,False),\
        })),
        'ENABLEs':(0x4,10,(agwb.ControlRegister,)),
        'STATUS':(0xe,(agwb.StatusRegister,)),
    }


class MAIN(agwb.Block):
    x__size = 131072
    x__id = 0x89bd20d0
    x__ver = 0xce69ae7e
    x__fields = {
        'EXTHUGE':(0x10000,(HTEST,)),\
        'EXTERN':(0xf000,4,(EXTTEST,)),\
        'LINKS':(0xee00,31,(SYS1,)),\
        'ID':(0x2000,(agwb.StatusRegister,)),\
        'VER':(0x2001,(agwb.StatusRegister,)),\
        'TEST_RW':(0x2004,(agwb.ControlRegister,)),\
        'TEST_WO':(0x2005,(agwb.ControlRegister,)),\
        'TEST_RO':(0x2006,(agwb.ControlRegister,)),\
        'TEST_TOUT':(0x2007,(agwb.ControlRegister,)),\
        'CTRL':(0x2008,(agwb.ControlRegister,
        {\
            'CLK_ENABLE':agwb.BitField(4,0,False),\
            'CLK_FREQ':agwb.BitField(8,5,False),\
            'PLL_RESET':agwb.BitField(9,9,False),\
        })),
        'TEST_OUT':(0x2009,3,(agwb.ControlRegister,)),
        'TEST_IN':(0x200c,5,(agwb.StatusRegister,)),
    }

