#ifndef __SYS1__INC_H
#define __SYS1__INC_H
const uint32_t agwb_SYS1_ID_VAL = 0x5bd964c2;
const uint32_t agwb_SYS1_VER_VAL = 0xb6e6d1d1;
static inline uint32_t agwb_SYS1_CTRL_START_get(uint32_t * ptr) { 
  return ((* ptr) >> 0x0) & 0x1;
};
static inline void agwb_SYS1_CTRL_START_set(uint32_t * ptr, uint32_t val) { 
  * ptr = ((* ptr) & 0xfffffffe) | ((val & 0x1) << 0x0);
};
static inline int32_t agwb_SYS1_CTRL_SPEED_get(uint32_t * ptr) { 
  int32_t res = (((* ptr) >> 0x1) & 0xf);
  return (res & 0x8) ? (res | 0xfffffff0) : res;
 };
static inline void agwb_SYS1_CTRL_SPEED_set(uint32_t * ptr, int32_t val) { 
  * ptr = ((* ptr) & 0xffffffe1) | ((val & 0xf) << 0x1);
};
static inline uint32_t agwb_SYS1_CTRL_STOP_get(uint32_t * ptr) { 
  return ((* ptr) >> 0x5) & 0x1;
};
static inline void agwb_SYS1_CTRL_STOP_set(uint32_t * ptr, uint32_t val) { 
  * ptr = ((* ptr) & 0xffffffdf) | ((val & 0x1) << 0x5);
};
static inline uint32_t agwb_SYS1_Test1_FIELD1_get(uint32_t * ptr) { 
  return ((* ptr) >> 0x0) & 0x1;
};
static inline void agwb_SYS1_Test1_FIELD1_set(uint32_t * ptr, uint32_t val) { 
  * ptr = ((* ptr) & 0xfffffffe) | ((val & 0x1) << 0x0);
};
static inline int32_t agwb_SYS1_Test1_FIELD2_get(uint32_t * ptr) { 
  int32_t res = (((* ptr) >> 0x1) & 0xf);
  return (res & 0x8) ? (res | 0xfffffff0) : res;
 };
static inline void agwb_SYS1_Test1_FIELD2_set(uint32_t * ptr, int32_t val) { 
  * ptr = ((* ptr) & 0xffffffe1) | ((val & 0xf) << 0x1);
};
static inline uint32_t agwb_SYS1_Test1_FIELD3_get(uint32_t * ptr) { 
  return ((* ptr) >> 0x5) & 0x1;
};
static inline void agwb_SYS1_Test1_FIELD3_set(uint32_t * ptr, uint32_t val) { 
  * ptr = ((* ptr) & 0xffffffdf) | ((val & 0x1) << 0x5);
};
typedef struct {
  volatile uint32_t ID;
  volatile uint32_t VER;
  volatile uint32_t CTRL;
  volatile uint32_t Test1[1];
  volatile uint32_t STATUS;
  volatile uint32_t ENABLEs[10];
  volatile uint32_t filler1[1];
} __attribute__((aligned(4))) agwb_SYS1 ;
#endif
