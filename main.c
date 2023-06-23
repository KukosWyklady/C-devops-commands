#include <src.h>

#include <stdlib.h>
#include <assert.h>

void test_src(void)
{
    {
        register const size_t num_entries = 1 * 1000 * 1000;
        register const int start_value = 1;
        register const int add_value = 2;
        int* buf = alloc_buffer(num_entries);
        assert(buf != NULL);

        init_buffer(buf, num_entries, start_value, add_value);
        for (size_t i = 0; i < num_entries; ++i)
            assert(buf[i] == start_value + (int)i * add_value);

        dealloc_buffer(buf);
    }
}

int main(void)
{
    test_src();

    return 0;
}