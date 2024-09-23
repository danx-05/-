#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[]) {
    FILE *input_file = fopen(argv[1], "r");
    if (inputfile == NULL) {
        perror("Ошибка при открытии файла");
        return 1;
    }
    FILE *out_file = fopen(argv[2], "w");
    if (out_file == NULL) {
        perror("Ошибка при открытии файла");
        return 1;
    }
    char line[256];
    int c = 1;
    while (fgets(line, sizeof(line), input_file) != NULL && c < 4) {
        fputs(line, out_file);
        c++;
    }
    fclose(input_file);
    fclose(out_file);
    return 0;
}
