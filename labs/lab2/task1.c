#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main()
{
    srand(time(NULL));
    int size = rand() % 20;
    int arr[size+1];
    for (int i = 0; i < size; i++){
        arr[i] = rand()%1000 * pow(-1,rand()%2);
        printf("%d ", arr[i]);
    }
    return 0;
}
