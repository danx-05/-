#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
struct node
{
    float  value;
    struct node *next;
};
struct myStack
{
    struct node *pointer;
    int count;
};
struct myStack *create_stack()
{
    struct myStack *temp = (struct myStack *)malloc(sizeof(struct myStack));
    temp->pointer = NULL;
    temp->count = 0;
    return temp;
}
void push(struct myStack *stack, float value)
{
    if (!stack) return;
    struct node *t = (struct node *)malloc(sizeof(struct node));
    t->value = value;
    if (!stack->pointer)
    {
        t->next = NULL;
        stack->pointer = t;
    }
    else
    {
        t->next = stack->pointer;
        stack->pointer = t ;
    }
    stack->count++;
}
float pop(struct myStack *stack)
{
    if (!stack || !stack->pointer) return 0;
    float value = stack->pointer->value;
    struct node *del = stack->pointer;
    stack->pointer = stack->pointer->next;
    free(del);
    stack->count--;
    return value;
}
float peek(struct myStack *stack)
{
    if (!stack || !stack->pointer) return 0;
    return stack->pointer->value;
}
int isEmpty(struct myStack *stack)
{
    return !stack->pointer;
}
int main(int argc, char *argv[])
{
    if (argc < 2){return 1;}
    FILE *file;
    file = fopen(argv[1],"r");
    if (file == NULL){return 1;}
    char str[100];
    while (fscanf(file,"%s",str) == 1){
        struct myStack *st = create_stack();
        float x;
        float y;
        for(int i = 0; str[i] != 0; i++)
        {
            if (isdigit(str[i])) push(st,(float)str[i] - 48);
            switch(str[i]){
                case '+':
                    x = pop(st);
                    y = pop(st);
                    push(st,y+x);
                    break;
                case '-':
                    x = pop(st);
                    y = pop(st);
                    push(st,y-x);
                    break;
                case '*':
                    x = pop(st);
                    y = pop(st);
                    push(st,y*x);
                    break;
                case '/':
                    x = pop(st);
                    y = pop(st);
                    push(st,y/x);
                    break;
            }
        }
        printf("%.2f\n",pop(st));
    }

    return 0;
}
