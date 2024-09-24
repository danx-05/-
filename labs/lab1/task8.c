#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main() {
    FILE *input_file, *temp_file;
    char line[100];
    char new_str[100];
    printf("Input new str: ");
    fgets(new_str,100,stdin);
    new_str[strcspn(new_str,"\n")] = '\0';
    input_file = fopen("t8","r");
    if (input_file == NULL){
        return 1;
    }
    temp_file = fopen("temp","w");
    fprintf(temp_file, "%s\n", new_str);
    while (fgets(line,100,input_file) != NULL){
        fputs(line, temp_file);
    }
    fclose(input_file);
    fclose(temp_file);
    input_file = fopen("t8","w");
    temp_file = fopen("temp", "r");
    while (fgets(line, 100, temp_file) != NULL){
        fputs(line,input_file);
    }
    fclose(input_file);
    fclose(temp_file);
    remove("temp");
    return 0;
}
