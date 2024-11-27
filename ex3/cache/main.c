/* 211788625 evyatar paz */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef unsigned char uchar;

typedef struct cache_line_s
{
    uchar valid;
    uchar frequency;
    long int tag;
    uchar *block;
} cache_line_t;

typedef struct cache_s
{
    uchar s;
    uchar t;
    uchar b;
    uchar E;
    cache_line_t **cache;
} cache_t;

void print_cache(cache_t cache)
{
    int S = 1 << cache.s;
    int B = 1 << cache.b;

    for (int i = 0; i < S; i++)
    {
        printf("Set %d\n", i);
        for (int j = 0; j < cache.E; j++)
        {
            printf("%1d %d 0x%0*lx ", cache.cache[i][j].valid,
                   cache.cache[i][j].frequency, cache.t, cache.cache[i][j].tag);
            for (int k = 0; k < B; k++)
            {
                printf("%02x ", cache.cache[i][j].block[k]);
            }
            puts("");
        }
    }
}
cache_t initialize_cache(uchar s, uchar t, uchar b, uchar E)
{
    cache_t cache = {s, t, b, E, NULL};
    int S = 1 << s;
    cache.cache = calloc(S, sizeof(cache_line_t *)); // S is the number of sets
    int B = 1 << b;                                  // B is the block size

    for (int i = 0; i < S; i++) // for each set
    {
        cache.cache[i] = calloc(sizeof(cache_line_t), cache.E); // E is the number of lines
        for (int j = 0; j < cache.E; j++)
        {
            cache.cache[i][j].valid = 0;
            cache.cache[i][j].frequency = 0;
            cache.cache[i][j].tag = 0;
            cache.cache[i][j].block = malloc(B);
        }
    }
    return cache;
}

uchar read_byte(cache_t cache, uchar *start, long int off)
{
    int s = cache.s;
    int b = cache.b;
    int t = cache.t;
    long address = start[off];
    unsigned long tag = (address >> (b + s)) & ((1 << t) - 1);
    unsigned long set = (address >> b) & ((1 << s) - 1);
    unsigned long block = address & ((1 << b) - 1);

    for (int i = 0; i < cache.E; i++)
    {
        if (cache.cache[set][i].valid == 0)
        {
            cache.cache[set][i].valid = 1;
            cache.cache[set][i].tag = tag;
            cache.cache[set][i].frequency = 1;
            memcpy(cache.cache[set][i].block, &start[off - block], 1 << b);
            return cache.cache[set][i].block[block];
        }
        if (cache.cache[set][i].tag == tag)
        {
            cache.cache[set][i].frequency++;
            return cache.cache[set][i].block[block];
        }
    }
    int min = 0;
    for (int i = 0; i < cache.E; i++)
    {
        if (cache.cache[set][i].frequency < cache.cache[set][min].frequency)
        {
            min = i;
        }
    }
    cache.cache[set][min].tag = tag;
    cache.cache[set][min].frequency = 1;
    memcpy(cache.cache[set][min].block, &start[off - block], 1 << b);
    return cache.cache[set][min].block[block];
}

void write_byte(cache_t cache, uchar *start, long int off, uchar new)
{
    int s = cache.s;
    int b = cache.b;
    int t = cache.t;
    long address = start[off];
    unsigned long tag = (address >> (b + s)) & ((1 << t) - 1);
    unsigned long set = (address >> b) & ((1 << s) - 1);
    unsigned long block = address & ((1 << b) - 1);

    for (int i = 0; i < cache.E; i++)
    {
        if (cache.cache[set][i].valid == 0)
        {
            cache.cache[set][i].valid = 1;
            cache.cache[set][i].tag = tag;
            cache.cache[set][i].frequency = 1;
            memcpy(cache.cache[set][i].block, &start[off - block], 1 << b);
            cache.cache[set][i].block[block] = new;
            start[off] = new;
            return;
        }
        if (cache.cache[set][i].tag == tag)
        {
            cache.cache[set][i].frequency = 1;
            cache.cache[set][i].block[block] = new;
            start[off] = new;
            return;
        }
    }
    int min = 0;
    for (int i = 0; i < cache.E; i++)
    {
        if (cache.cache[set][i].frequency < cache.cache[set][min].frequency)
        {
            min = i;
        }
    }
    cache.cache[set][min].tag = tag;
    cache.cache[set][min].frequency = 1;
    memcpy(cache.cache[set][min].block, &start[off - block], 1 << b);
    cache.cache[set][min].block[block] = new;
    start[off] = new;
    return;
}

int main()
{
    int n;
    printf("Size of data: ");
    scanf("%d", &n);
    uchar *mem = malloc(n);
    printf("Input data >> ");
    for (int i = 0; i < n; i++)
        scanf("%hhd", mem + i);

    int s, t, b, E;
    printf("s t b E: ");
    scanf("%d %d %d %d", &s, &t, &b, &E);
    cache_t cache = initialize_cache(s, t, b, E);

    while (1)
    {
        scanf("%d", &n);
        if (n < 0)
            break;
        read_byte(cache, mem, n);
    }

    puts("");
    print_cache(cache);

    free(mem);
}
