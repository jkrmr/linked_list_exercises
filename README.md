Linked List Exercises
=====================

### Reverse a linear linked list

Both non-destructively and with mutation:

```
λ reverse_linked_list 5

Usage: reversed_linked_list [LIST_LENGTH]

original linked list:
{ 7, 9, 0, 6, 0 }
reversed (sans mutation):
{ 0, 6, 0, 9, 7 }
reversed (in-place)
{ 0, 6, 0, 9, 7 }
```

### Floyd's cycle detection algorithm

Use it to determine if a linear linked list has cyclically infinite length.

For a finite list:

```
λ detect_infinite_list 5

Usage: detect_infinite_list [LIST_LENGTH]   # default: 5, for infinite: inf"

Finite list:
{ 8, 1, 4, 5, 2 }

Cycle detection result:
false
```

For an infinite list:

```
λ detect_infinite_list inf

Usage: detect_infinite_list [LIST_LENGTH]   # default: 5, for infinite: inf"

Infinite list:
#<LinkedList::List:0x007fa6bb80b3a8 @length=3, @head=#<LinkedList::Node:0x007fa6bb80b358 @value=0, @next_node=#<LinkedList::Node:0x007fa6bb80b268 @value=1, @next_node=#<LinkedList::Node:0x007fa6bb80b2e0 @value=2, @next_node=#<LinkedList::Node:0x007fa6bb80b358 ...>>>>>

Cycle detection result:
true
```
