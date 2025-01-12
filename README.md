# janet-binheap

A pure janet implementation of binary heap with priority queue operations (peek, pop).

## Installation

```
jpm install 'https://github.com/postrov/janet-binheap'
```

or just add 'https://github.com/postrov/janet-binheap' to dependencies in your `project.janet`

## Usage examples

* For full API docs look [here](api.md)
* For more elaborate examples, check out [examples](examples/) directory.

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
