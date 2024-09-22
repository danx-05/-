#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
int main()
{
    srand(time(NULL));
    int size = rand() % 20;
    int arr[1 + size];
    printf("Array: ");
    for (int i = 0; i < size + 1; i++){
        arr[i] = rand()%1000 * pow(-1,rand()%2);
        printf("%d ", arr[i]);
    }
    printf("\n");
    FILE *file;
    file = fopen("task2","a");
    if (file == NULL) {
        printf("Error\n");
	return 1;
    }
    for (int i = size; i >= 0; i--)
    fprintf(file,"%d ", arr[i]);
    fprintf(file,"\n");
    fclose(file);
    return 0;
}
