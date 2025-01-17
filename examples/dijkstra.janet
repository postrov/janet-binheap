(import ../src/heap :as h)

(def graph @{:a [[:b 10] [:c 100] [:d 1000]]
             :b [[:c 10]]
             :c [[:d 10]]
             :d []})

(defn shortest-paths [graph start &opt end]
  (def visited @{})
  (def unvisited (h/make-heap
                   (map |[(if (= $ start) 0 math/inf) $] (keys graph))
                   :key-fn first))
  (def not-visited? (fn [[neighbor _]] (not (has-key? visited neighbor))))
  (loop [_ :iterate true
         :let [cur (h/pop unvisited)]
         :until (or
                  (nil? cur)
                  (= math/inf (first cur))
                  (has-key? visited end))]
    (def [cur-dist cur-node] cur)
    (set (visited cur-node) cur-dist)
    (each [neigh-node neigh-dist] (filter not-visited? (graph cur-node))
      (def candidate-dist (+ cur-dist neigh-dist))
      (h/update-key unvisited
                    (fn [[prev-best node]]
                      (and
                        (= node neigh-node)
                        (> prev-best candidate-dist)))
                    (fn [_] [candidate-dist neigh-node]))))
  visited)

(defn main [& args]
  (pp (shortest-paths graph :a))) # => @{:a 0 :b 10 :c 20 :d 30}

