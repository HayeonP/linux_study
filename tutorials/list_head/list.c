#include <stdlib.h>
#include <assert.h>
#include "list.h"

struct stack_entry{
    int id;
    struct list_head list;
};

struct queue_entry{
    int id;
    struct list_head list;
};

int main(){
    printf("# Stack\n");
    /* Create root list head */
    LIST_HEAD(stack); 
    struct stack_entry *sptr;

    /* Check empty */
    printf("is stack empty?: %d\n", list_empty(&stack));

    /* Initialize stack entries */
    int i;
    for (i = 0; i < 5; i++){
        sptr = malloc(sizeof(*sptr));
        sptr->id = i;

        /* Create list_head for entry */
        INIT_LIST_HEAD(&sptr->list);
        list_add(&sptr->list, &stack);
    }

    /* Traverse */
    struct stack_entry *s_entry;
    printf("- Traverse\n");
    printf("%d\n", sptr->id);
    list_for_each_entry(sptr, &stack, list){
        printf("stack id: %d\n", sptr->id);
    }

    /* Check empty */
    printf("is stack empty?: %d\n", list_empty(&stack));

    printf("# Queue\n");
    /* Create root list head */
    LIST_HEAD(queue); 
    struct queue_entry *qptr;
    
    /* Initialize queue entries */
    for (i = 0; i < 5; i++){
        qptr = malloc(sizeof(*qptr));
        qptr->id = i;

        /* Create list_head for entry */
        INIT_LIST_HEAD(&qptr->list);
        list_add_tail(&qptr->list, &queue);
    }
        
    /* Traverse */
    printf("- Traverse\n");
    list_for_each_entry(qptr, &queue, list){
        printf("queue id: %d\n", qptr->id);
    }

    /* Reverse Traverse */
    printf("- Reverse traverse\n");
    list_for_each_entry_reverse(qptr, &queue, list){
        printf("queue id: %d\n", qptr->id);
    }

    /* Remove entry - Should free variables in entry */
    struct queue_entry *erase;
    list_for_each_entry(qptr, &queue, list){
        if(qptr->id == 3) erase = qptr;
    }
    list_del(&erase->list); 
    printf("- Remove entry 3\n");
    list_for_each_entry(qptr, &queue, list){
        printf("queue id: %d\n", qptr->id);
    }

    /* Reorder 0 1 2 4 to 1 2 0 4 */
    struct queue_entry *target, *to;
    list_for_each_entry(qptr, &queue, list){
        if(qptr->id == 0) target = qptr;
        else if(qptr->id == 2) to = qptr;
    }
    list_move(&target->list, &to->list);
    printf("- Move 0 to behind the 2\n");
    list_for_each_entry(qptr, &queue, list){
        printf("queue id: %d\n", qptr->id);
    }

    /* Move first entry to tail */
    struct queue_entry *first = container_of(queue.next, struct queue_entry, list);
    list_move_tail(&first->list, &queue);
    printf("- Move frist entry to end\n");
    list_for_each_entry(qptr, &queue, list){
        printf("queue id: %d\n", qptr->id);
    }

    return 0;
}
