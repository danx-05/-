#include <stdio.h>
#include <stdlib.h>
struct goods
{
    char name[128];
    float price;
};
void swap(struct goods *xp, struct goods *yp)
{
    struct goods temp = *xp;
    *xp = *yp;
    *yp = temp;
}
void Sort(struct goods *mas, int countString)
{
    int i, j;
    for (i = 0; i < countString - 1; i++)
    {
        for (j = 0; j < countString - i - 1; j++)
        {
            if (mas[j].price > mas[j + 1].price)
            {
                swap(&mas[j], &mas[j + 1]);
            }
        }
    }
}
int main()
{
    FILE *inputFile;
    FILE *outputFile;
    inputFile = fopen("inputFile.txt", "r");
    if (inputFile == NULL)
    {
        printf("Ошибка при открытии входного файла.\n");
        return 1;
    }
    int countString = 1;
    char ch;
    while ((ch = fgetc(inputFile)) != EOF)
    {
        if (ch == '\n')
        {
            countString++;
        }
    }
    struct goods shop[countString];
    int i = 0;
    fseek(inputFile, 0, SEEK_SET);
    
    while (fscanf(inputFile, "%s %f", shop[i].name, &shop[i].price) != EOF)
    {
        printf("%s\n", shop[i].name);
        i++;
    }
    Sort(shop, countString);
    outputFile = fopen("output.txt", "w");
    if (outputFile == NULL)
    {
        printf("Ошибка при открытии выходного файла.\n");
        return 1;
    }
    for (int i = 0; i < countString; i++)
    {
        fprintf(outputFile, "%s %.2f\n", shop[i].name, shop[i].price);
    }
    fclose(outputFile);
    fclose(inputFile);
    
    
    return 0;
}
