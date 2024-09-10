#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>

int main()
{
    srand(time(NULL));
    int size;
    printf("Input size: ");
    scanf("%d",&size);
    
    float arg1;
    printf("Input arg1: ");
    scanf("%f",&arg1);
    
    float arg2;
    printf("Input arg2: ");
    scanf("%f",&arg2);
    
    float arr[size];
    
    for (int i = 0; i < size; i++){
        arr[i] = arg1 + (float)rand()/RAND_MAX * (arg2 - arg1);
        printf("%f ", arr[i]);
        
    }
    printf("\n");
    
    return 0;
}
