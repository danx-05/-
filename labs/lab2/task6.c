#include <stdio.h>
#include <stdlib.h>
typedef struct s_stack{
    char data;
    struct s_stack* next;
} Stack;

Stack *create_node(char data){
    Stack *node = (Stack *)malloc(sizeof(Stack));
    node->data = data;
    node->next = NULL;
    return node;
}

void push(Stack** stack, char data)
{
    Stack* new_node = create_node(data);
    new_node->next = *stack;
    *stack = new_node;
}

int main() 
{
    Stack *s = NULL;
    push(&s,'f');
    return 0;
}
