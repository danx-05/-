#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[]) {
    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        perror("Ошибка при открытии файла");
        return 1;
    }
    char line[256];
    while (fgets(line, sizeof(line), file)) {
        printf("%s", line);
    }
    fclose(file);
    return 0;
}
