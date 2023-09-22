#include<stdio.h>
#include<math.h>

int main()
{
    unsigned long long int max = (unsigned long long int)(pow(2,64)-1); 
    unsigned long long int maxover = (unsigned long long int)(pow(2,127));
    unsigned long long int min = (unsigned long long int)(0);
    unsigned long long int minover = (unsigned long long int)(pow(2,64)*-1);
    printf("Highest number represented by unsigned long long int is %llu which is calculated by (2^64 - 1)\n", max);
    printf("Proving by overflowing above limit (2^127) value of variable still is %llu\n", maxover);
    printf("Lowest number represented by unsigned long long int is %llu\n", min);
    printf("Proving by overflowing below limit (2^64 * -1) value of variable still is %llu\n", minover);
    return 0;
}
