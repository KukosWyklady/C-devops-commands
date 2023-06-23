#include <src.h>

#include <stdlib.h>
#include <stdio.h>

static void fill_buffer(int buf[const], const size_t num_entries, const int start_value, const int add_value)
{
    for (size_t i = 0; i < num_entries; ++i)
        buf[i] = start_value + ((int)i * add_value);
}

int* alloc_buffer(const size_t num_entries)
{
    if (num_entries == 0)
    {
        fprintf(stderr, "num_entries should be > 0, got %zu\n", num_entries);
        return NULL;
    }

    int* const buf = malloc(sizeof(*buf) * num_entries);
    if (buf == NULL)
    {
        fprintf(stderr, "Malloc error on size %zu\n", sizeof(*buf) * num_entries);
        return NULL;
    }

    return buf;
}


void init_buffer(int buf[const], const size_t num_entries, const int start_value, const int add_value)
{
    if (buf == NULL)
    {
        fprintf(stderr, "buf should be not NULL, got %p\n", (void *)buf);
        return;
    }

    if (num_entries == 0)
    {
        fprintf(stderr, "num_entries shoule be >0, got %zu\n", num_entries);
        return;
    }

    fill_buffer(buf, num_entries, start_value, add_value);
}

void dealloc_buffer(int buf[const])
{
    if (buf == NULL)
    {
        fprintf(stderr, "buf should be not NULL, got %p\n", (void *)buf);
        return;
    }

    free(buf);
}
