#ifndef SRC_H
#define SRC_H

#include <stddef.h>

int* alloc_buffer(size_t num_entries);
void dealloc_buffer(int buf[]);
void init_buffer(int buf[], size_t num_entries, int start_value, int add_value);

#endif