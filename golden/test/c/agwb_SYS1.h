#ifndef __SYS1__INC_H
#define __SYS1__INC_H
const uint32_t agwb_SYS1_ID_VAL = 0x5bd964c2;
const uint32_t agwb_SYS1_VER_VAL = 0xc99e6bdc;
static inline uint32_t agwb_SYS1_CTRL_START_get(uint32_t * ptr) { 
  return ((* ptr) >> 0x0) & 0x1;
};
static inline void agwb_SYS1_CTRL_START_set(uint32_t * ptr, uint32_t val) { 
  * ptr = ((* ptr) & 0xfffffffe) | ((val & 0x1) << 0x0);
};
static inline uint32_t agwb_SYS1_CTRL_STOP_get(uint32_t * ptr) { 
  return ((* ptr) >> 0x1) & 0x1;
};
static inline void agwb_SYS1_CTRL_STOP_set(uint32_t * ptr, uint32_t val) { 
  * ptr = ((* ptr) & 0xfffffffd) | ((val & 0x1) << 0x1);
};
static inline int32_t agwb_SYS1_CTRL_SPEED_get(uint32_t * ptr) { 
  int32_t res = (((* ptr) >> 0x2) & 0xf);
  return (res & 0x8) ? (res | 0x1ffffffe0) : res;
 };
static inline void agwb_SYS1_CTRL_SPEED_set(uint32_t * ptr, int32_t val) { 
  * ptr = ((* ptr) & 0xffffffc3) | ((val & 0xf) << 0x2);
};
static inline uint32_t agwb_SYS1_X2_B1_get(uint32_t * ptr) { 
  return ((* ptr) >> 0x0) & 0x1;
};
static inline void agwb_SYS1_X2_B1_set(uint32_t * ptr, uint32_t val) { 
  * ptr = ((* ptr) & 0xfffffffe) | ((val & 0x1) << 0x0);
};
static inline uint32_t agwb_SYS1_X2_B2_get(uint32_t * ptr) { 
  return ((* ptr) >> 0x1) & 0x1;
};
static inline void agwb_SYS1_X2_B2_set(uint32_t * ptr, uint32_t val) { 
  * ptr = ((* ptr) & 0xfffffffd) | ((val & 0x1) << 0x1);
};
static inline uint32_t agwb_SYS1_X2_B3_get(uint32_t * ptr) { 
  return ((* ptr) >> 0x2) & 0x1;
};
static inline void agwb_SYS1_X2_B3_set(uint32_t * ptr, uint32_t val) { 
  * ptr = ((* ptr) & 0xfffffffb) | ((val & 0x1) << 0x2);
};
typedef struct {
  volatile uint32_t ID;
  volatile uint32_t VER;
  volatile uint32_t CTRL;
  volatile uint32_t X2[1];
  volatile uint32_t ENABLEs[10];
  volatile uint32_t STATUS;
  volatile uint32_t filler1[1];
} __attribute__((aligned(4))) agwb_SYS1 ;
#endif
