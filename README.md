# janet-binheap

A pure janet implementation of binary heap with priority queue operations (peek, pop).

## Usage examples

```janet
(import janet-binheap/heap :as h)

# Simple int max heap:
(def heap (h/make-heap (range 10) :sort-fn >))
(h/pop heap) # => 9
(h/drain heap)) # => @[8 7 6 5 4 3 2 1 0]

# A heap with with compound values:
(def heap (h/make-heap [[:n 2] [:e 3] [:a 1] [:t 4] [:j 0]] :key-fn |(get $ 1) :sort-fn <))
(map first (h/drain heap)) # => @[:j :a :n :e :t]

# Updating key:
(def heap (h/make-heap [[:a 1] [:b 2] [:c 3]] :key-fn first))
(h/update-key heap |(= (first $) :b) |[:d (+ 10 (get $ 1))]) # => (:d 12)
(h/drain heap) # => @[(:a 1) (:c 3) (:d 12)]
```

## janet-binheap API

### src/heap

[add](#add), [add-all](#add-all), [drain](#drain), [empty-heap?](#empty-heap), [make-heap](#make-heap), [merge-heaps](#merge-heaps), [peek](#peek), [pop](#pop), [update-key](#update-key)

### add

**function**  | [source][1]

```janet
(add heap item)
```

Add an item to the heap.

[1]: src/heap.janet#L70

### add-all

**function**  | [source][2]

```janet
(add-all heap elements)
```

Add all elements to the heap. May be more efficient than adding one by one.

[2]: src/heap.janet#L53

### drain

**function**  | [source][3]

```janet
(drain heap)
```

Pop all elements in heap into an array and returns it. The heap is left empty.

[3]: src/heap.janet#L110

### empty-heap?

**function**  | [source][4]

```janet
(empty-heap? heap)
```

Return true if the heap is empty, false otherwise.

[4]: src/heap.janet#L118

### make-heap

**function**  | [source][5]

```janet
(make-heap elements &named sort-fn key-fn)
```

Create a heap with given elements, can specify `sort-fn` (default `<`) and `key-fn` (default `identity`).

[5]: src/heap.janet#L59

### merge-heaps

**function**  | [source][6]

```janet
(merge-heaps & heaps)
```

Merge heap into the first one. Returns first heap.

[6]: src/heap.janet#L123

### peek

**function**  | [source][7]

```janet
(peek heap)
```

Return root of the heap (smallest key with default `<` as key function).

[7]: src/heap.janet#L78

### pop

**function**  | [source][8]

```janet
(pop heap)
```

Remove root of the heap and return it.

[8]: src/heap.janet#L85

### update-key

**function**  | [source][9]

```janet
(update-key heap pred update-fn)
```

Find first element that satisfies the `pred` and replace it with value returned by `(update-fn element)`.

[9]: src/heap.janet#L96

