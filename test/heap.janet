(use judge)
(import ../src/heap :as h)

(defn- test-sort-heap []
  (def elements [1 8 2 3 5 4 2 12 7])
  (def heap (h/make-heap elements))
  (h/drain heap))

(test (test-sort-heap) @[1 2 2 3 4 5 7 8 12])

(defn- test-merge-ok []
  (let [heap1 (h/make-heap [1 2 8 12 3 4 5 0 17 6])
        heap2 (h/make-heap [-1 -2 5 -3 -4])]
    (h/merge-heaps heap1 heap2)
    (h/drain heap1)))

(test (test-merge-ok) @[-4 -3 -2 -1 0 1 2 3 4 5 5 6 8 12 17])

(defn- test-merge-incompatible []
  (let [heap1 (h/make-heap [1 2 3] :sort-fn > :key-fn inc)
        heap2 (h/make-heap [4 5 6])]
    (h/merge-heaps heap1 heap2)
    (h/drain heap1)))


(test-error (test-merge-incompatible) "Attemtped to merge incompatible heaps (key-fn and sort-fn must be the same for all heaps).")

(defn- test-update-key []
  (let [heap (h/make-heap [[:a 1] [:b 2] [:c 3]] :sort-fn > :key-fn first)]
    (h/update-key heap |(= (first $) :b) |[:d (+ 10 ($ 1))])
    (h/drain heap)))

(test (test-update-key) @[[:d 12] [:c 3] [:a 1]])
