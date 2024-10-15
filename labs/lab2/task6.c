#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
struct node
{
    int value;
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
void push(struct myStack *stack, int value)
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
int pop(struct myStack *stack)
{
    if (!stack || !stack->pointer) return 0;
    char value = stack->pointer->value;
    struct node *del = stack->pointer;
    stack->pointer = stack->pointer->next;
    free(del);
    stack->count--;
    return value;
}
int peek(struct myStack *stack)
{
    if (!stack || !stack->pointer) return 0;
    return stack->pointer->value;
}
int stack_size(struct myStack *stack)
{
    return stack->count;
}
int isEmpty(struct myStack *stack)
{
    return !stack->pointer;
}
#include <stdio.h>

int main()
{
    struct myStack *st = create_stack();
    for (int i = 0; i <= 10; i++){
        push(st,i);
    }
    printf("%d\n", peek(st));
    for (int i = 0; i <= 5; i++){
        printf("%d ", pop(st));
    }
    return 0;
}
