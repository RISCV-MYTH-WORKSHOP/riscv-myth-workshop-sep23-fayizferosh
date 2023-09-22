#include<stdio.h>
#include<math.h>

int main()
{
    long long int max = (long long int)(pow(2,63)-1); 
    long long int maxover = (long long int)(pow(2,127));
    long long int min = (long long int)(pow(2,63)*-1);
    long long int minover = (long long int)(pow(2,127)*-1);
    printf("Highest positive number represented by signed long long int is %lld which is calculated by (2^63 - 1)\n", max);
    printf("Proving by overflowing above limit (2^127) value of variable still is %lld\n", maxover);
    printf("Lowest negative number represented by signed long long int is %lld which is calculated by (2^63 * -1)\n", min);
    printf("Proving by overflowing below limit (2^127 * -1) value of variable still is %lld\n", minover);
    return 0;
}
