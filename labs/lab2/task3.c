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
    float arr[size];
    
    for (int i = 0; i < size; i++){
        arr[i] = (float)rand()/RAND_MAX * pow(-1,rand()%2);
        printf("%f ", arr[i]);
        
    }
    printf("\n");
    
    return 0;
}
