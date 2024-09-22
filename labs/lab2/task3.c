#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char* argv[])
{
    srand(time(NULL));
    if (argc < 2){return 1;}
    int size = atoi(argv[1]);
    if (size < 1){
	printf("Error");
	return 1;
    }
    float arr[size];
    for (int i = 0; i < size; i++){
        arr[i] = (float)rand()/RAND_MAX;
        printf("%f ", arr[i]);
    }
    printf("\n");
    return 0;
}
