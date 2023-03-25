#include <stdio.h>

int sum(int inp1, int inp2, int inp3, int inp4)
{
    printf("C OUT: %d %d %d %d\r\n", inp1, inp2, inp3, inp4);
    int sum = inp1 + inp2 + inp3 + inp4;
    printf("C OUT: Sum: %d\r\n", sum);
    return sum;
}