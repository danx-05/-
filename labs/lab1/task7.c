#include <stdio.h>
int main() {
    FILE *file;
    char str[] = "\nНовая строчка";
    file = fopen("a2", "a");
    if (file == NULL) {
        perror("Ошибка при открытии файла");
        return 1;
    }
    fprintf(file, "%s", str);
    fclose(file);
    
    return 0;
}
