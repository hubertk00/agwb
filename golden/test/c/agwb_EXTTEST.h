#ifndef __EXTTEST__INC_H
#define __EXTTEST__INC_H
typedef struct {
  volatile uint32_t filler[1024];
}  __attribute__((aligned(4))) agwb_EXTTEST;
#endif
