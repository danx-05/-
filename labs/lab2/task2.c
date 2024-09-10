#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>

int main()
{
    srand(time(NULL));
    int size = rand() % 20;
    int arr[size];
    
    for (int i = 0; i < size; i++){
        arr[i] = rand()%100 * pow(-1,rand()%2);
        printf("%d ", arr[i]);
        
    }
    printf("\n");
    for (int i = size - 1; i >= 0; i--)
    printf("%d ", arr[i]);
    return 0;
}
