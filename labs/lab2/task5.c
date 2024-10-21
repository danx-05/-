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
void Sort(struct goods *mac, int n) {
    int flag;
    do {
        flag = 0;
        for (int i = 0; i < n - 1; i++) {
            if (mac[i].price > mac[i + 1].price) {
                swap(&mac[i], &mac[i + 1]);
                flag = 1;
            }
        }
    } while(flag);
}
int main()
{
    FILE *inputFile;
    FILE *outputFile;
    inputFile = fopen("inputFile", "r");
    if (inputFile == NULL)
    {
        printf("Ошибка при открытии входного файла.\n");
        return 1;
    }
    int countString = 0;
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
        i++;
    }
    Sort(shop, countString);
    outputFile = fopen("output", "w");
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
