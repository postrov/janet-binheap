(declare-project
  :name "janet-binheap"
  :description ```Janet implementation of binary heap with priority queue operations. ```
  :version "0.0.1"
  :dependencies ["https://github.com/ianthehenry/judge.git"])

(declare-source
  :prefix "janet-binheap"
  :source ["src/heap.janet"])
