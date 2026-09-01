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
    x__ver = 0xad9541a4
    x__fields = {
        'ID':(0x0,(agwb.StatusRegister,)),\
        'VER':(0x1,(agwb.StatusRegister,)),\
        'CTRL':(0x2,(agwb.ControlRegister,
        {\
            'START':agwb.BitField(0,0,False),\
            'SPEED':agwb.BitField(4,1,False),\
            'STOP':agwb.BitField(5,5,False),\
        })),
        'Test1':(0x3,1,(agwb.ControlRegister,
        {\
            'FIELD1':agwb.BitField(0,0,False),\
            'FIELD2':agwb.BitField(4,1,False),\
            'FIELD3':agwb.BitField(5,5,False),\
        })),
        'STATUS':(0x4,(agwb.StatusRegister,)),
        'ENABLEs':(0x5,10,(agwb.ControlRegister,)),
    }


class MAIN(agwb.Block):
    x__size = 131072
    x__id = 0x89bd20d0
    x__ver = 0x72acd6cd
    x__fields = {
        'EXTHUGE':(0x10000,(HTEST,)),\
        'EXTERN':(0xf000,4,(EXTTEST,)),\
        'LINKS':(0xee00,31,(SYS1,)),\
        'ID':(0x400,(agwb.StatusRegister,)),\
        'VER':(0x401,(agwb.StatusRegister,)),\
        'CR1':(0x402,(agwb.ControlRegister,)),
        'CTRL':(0x403,(agwb.ControlRegister,
        {\
            'CLK_ENABLE':agwb.BitField(4,0,False),\
            'CLK_FREQ':agwb.BitField(8,5,False),\
            'PLL_RESET':agwb.BitField(9,9,False),\
        })),
        'CR2':(0x404,(agwb.ControlRegister,)),
        'TEST_OUT':(0x405,3,(agwb.ControlRegister,)),
        'TEST_IN':(0x408,5,(agwb.StatusRegister,)),
    }

