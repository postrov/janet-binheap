# janet-binheap API

## src/heap

[add](#add), [add-all](#add-all), [drain](#drain), [is-empty?](#is-empty), [make-heap](#make-heap), [merge-heaps](#merge-heaps), [peek](#peek), [pop](#pop), [size](#size), [update-key](#update-key)

## add

**function**  | [source][1]

```janet
(add heap item)
```

Add an item to the heap.

[1]: src/heap.janet#L70

## add-all

**function**  | [source][2]

```janet
(add-all heap elements)
```

Add all elements to the heap. May be more efficient than adding one by one.

[2]: src/heap.janet#L53

## drain

**function**  | [source][3]

```janet
(drain heap)
```

Pop all elements in heap into an array and returns it. The heap is left empty.

[3]: src/heap.janet#L110

## is-empty?

**function**  | [source][4]

```janet
(is-empty? heap)
```

Return true if the heap is empty, false otherwise.

[4]: src/heap.janet#L118

## make-heap

**function**  | [source][5]

```janet
(make-heap elements &named sort-fn key-fn)
```

Create a heap with given elements, can specify `sort-fn` (default `<`) and `key-fn` (default `identity`).

[5]: src/heap.janet#L59

## merge-heaps

**function**  | [source][6]

```janet
(merge-heaps & heaps)
```

Merge heap into the first one. Returns first heap.

[6]: src/heap.janet#L123

## peek

**function**  | [source][7]

```janet
(peek heap)
```

Return root of the heap (smallest key with default `<` as key function).

[7]: src/heap.janet#L78

## pop

**function**  | [source][8]

```janet
(pop heap)
```

Remove root of the heap and return it.

[8]: src/heap.janet#L85

## size

**function**  | [source][9]

```janet
(size heap)
```

Returns the number of elements in heap.

[9]: src/heap.janet#L133

## update-key

**function**  | [source][10]

```janet
(update-key heap pred update-fn)
```

Find first element that satisfies the `pred` and replace it with value returned by `(update-fn element)`.

[10]: src/heap.janet#L96

