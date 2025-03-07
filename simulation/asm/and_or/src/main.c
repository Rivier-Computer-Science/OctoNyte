#include <stdio.h>
#include "and_or.h"

int main() {
    int a = 5, b = 3;

    printf("AND: %d\n", and_operation(a, b));
    printf("OR: %d\n", or_operation(a, b));

    return 0;
}
