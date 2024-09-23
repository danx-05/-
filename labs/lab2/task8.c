#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
struct node
{
    char value;
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
void push(struct myStack *stack, char value)
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
char pop(struct myStack *stack)
{
    if (!stack || !stack->pointer) return 0;
    char value = stack->pointer->value;
    struct node *del = stack->pointer;
    stack->pointer = stack->pointer->next;
    free(del);
    stack->count--;
    return value;
}
char peek(struct myStack *stack)
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
int ex(char x){
    switch (x){
        case '+': return 2;
        case '-': return 2;
        case '*': return 3;
        case '/': return 3;
        case '(': return 1;
    }
}
int main()
{
    struct myStack *st = create_stack();
    char str[30];
    printf("Input: ");
    scanf("%s",str);
    char ans[100];
    int j = 0;
    for (int i = 0; i < strlen(str); i++){
        if (isdigit(str[i])) {ans[j++] = str[i];}
        else{
            if (isEmpty(st)) {push(st,str[i]);}
            else{
                switch (str[i]){
                case '+':
                    while (ex(peek(st)) >= 2 && !isEmpty(st))
                    {
                        ans[j++] = pop(st);
                    }
                    push(st,'+');
                    break;
                case '-':
                    while (ex(peek(st)) >= 2 && !isEmpty(st))
                    {
                        ans[j++] = pop(st);
                    }
                    push(st,'-');
                    break;
                case '*':
                    while (ex(peek(st)) >= 3 && !isEmpty(st))
                    {
                        ans[j++] = pop(st);
                    }
                    push(st,'*');
                    break;
                case '/':
                    while (ex(peek(st)) >= 3 && !isEmpty(st))
                    {
                        ans[j++] = pop(st);
                    }
                    push(st,'/');
                    break;
                case '(':
                    push(st,'(');
                    break;
                case ')':
                    while(peek(st) != '('){
                        ans[j++] = pop(st);
                    }
                    pop(st);
                    break;
                }
            }
        }
    }
    while(!isEmpty(st)){
        ans[j++] = pop(st);
    }
    printf("%s\n", ans);
    return 0;
}
