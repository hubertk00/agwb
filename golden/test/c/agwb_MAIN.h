#ifndef __MAIN__INC_H
#define __MAIN__INC_H
const uint32_t agwb_MAIN_ID_VAL = 0x89bd20d0;
const uint32_t agwb_MAIN_VER_VAL = 0xc99e6bdc;
static inline uint32_t agwb_MAIN_CTRL_CLK_ENABLE_get(uint32_t * ptr) { 
  return ((* ptr) >> 0x0) & 0x1f;
};
static inline void agwb_MAIN_CTRL_CLK_ENABLE_set(uint32_t * ptr, uint32_t val) { 
  * ptr = ((* ptr) & 0xffffffe0) | ((val & 0x1f) << 0x0);
};
static inline uint32_t agwb_MAIN_CTRL_CLK_FREQ_get(uint32_t * ptr) { 
  return ((* ptr) >> 0x5) & 0xf;
};
static inline void agwb_MAIN_CTRL_CLK_FREQ_set(uint32_t * ptr, uint32_t val) { 
  * ptr = ((* ptr) & 0xfffffe1f) | ((val & 0xf) << 0x5);
};
static inline uint32_t agwb_MAIN_CTRL_PLL_RESET_get(uint32_t * ptr) { 
  return ((* ptr) >> 0x9) & 0x1;
};
static inline void agwb_MAIN_CTRL_PLL_RESET_set(uint32_t * ptr, uint32_t val) { 
  * ptr = ((* ptr) & 0xfffffdff) | ((val & 0x1) << 0x9);
};
#include <agwb_SYS1.h>
#include <agwb_EXTTEST.h>
#include <agwb_HTEST.h>
typedef struct {
  volatile uint32_t filler1[8192];
  volatile uint32_t ID;
  volatile uint32_t VER;
  volatile uint32_t TEST_ERR0;
  volatile uint32_t TEST_ERR1;
  volatile uint32_t TEST_RW;
  volatile uint32_t TEST_WO;
  volatile uint32_t TEST_RO;
  volatile uint32_t TEST_TOUT;
  volatile uint32_t CTRL;
  volatile uint32_t TEST_OUT[3];
  volatile uint32_t TEST_IN[5];
  volatile uint32_t filler2[52719];
  agwb_SYS1 LINKS[31];
  volatile uint32_t filler3[16];
  agwb_EXTTEST EXTERN[4];
  agwb_HTEST EXTHUGE;
} __attribute__((aligned(4))) agwb_MAIN ;
#endif
