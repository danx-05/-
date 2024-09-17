#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[]) {
    FILE *inputfile = fopen(argv[1], "r");
    if (inputfile == NULL) {
        perror("Ошибка при открытии файла");
        return 1;
    }
    FILE *outfile = fopen(argv[2], "w");
    if (outfile == NULL) {
        perror("Ошибка при открытии файла");
        return 1;
    }
    char line[256];
    int c = 1;
    while (fgets(line, sizeof(line), inputfile) != NULL && c < 4) {
        fputs(line, outfile);
        c++;
    }
    fclose(inputfile);
    fclose(outfile);
    return 0;
}
