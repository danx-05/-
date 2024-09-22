#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main()
{
    srand(time(NULL));
    int size = rand() % 20;
    int arr[size];
    for (int i = 0; i < size; i++){
        arr[i] = rand()%100;
        printf("%d ", arr[i]);
    }
    return 0;
}
