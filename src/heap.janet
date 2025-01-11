(defmacro- with-children [[left right] pos & body]
  (def p (gensym))
  ~(let
     [,p ,pos
      ,left (* 2 ,p)
      ,right (inc (* 2 ,p))]
     ,;body))

(defn- swap [arr pos1 pos2]
  (let [tmp (arr pos1)]
    (set (arr pos1) (arr pos2))
    (set (arr pos2) tmp)))

(defn- compare [heap parent child]
  (let [sort-fn (heap :sort-fn)
        key-fn (heap :key-fn)]
    (sort-fn (key-fn parent) (key-fn child))))

(defn- compare-pos [heap parent-pos child-pos]
  (let [{:content content
         :sort-fn sort-fn
         :key-fn key-fn} heap]
    (sort-fn (key-fn (content parent-pos)) (key-fn (content child-pos)))))

(defn- sift-up [heap pos]
  (unless (= 0 pos)
    (def parent-pos (div pos 2))
    (def content (heap :content))
    (when (compare-pos heap pos parent-pos)
      (swap (heap :content) pos parent-pos)
      (sift-up heap parent-pos))))

(defn- sift-down [heap pos]
  (def content (heap :content))
  (def len (length content))
  (with-children [left right] pos
    (cond
      (>= left len) nil # we finished
      (>= right len) (when (compare-pos heap left pos)
                       (swap content left pos))
      true (let [smaller-pos (if (compare-pos heap left right)
                               left
                               right)]
             (when (compare-pos heap smaller-pos pos)
               (swap content smaller-pos pos)
               (sift-down heap smaller-pos))))))

(defn- reconstruct [heap]
  (def len (-> (heap :content) length (div 2)))
  (loop [i :down-to [len 0]]
    (sift-down heap i)))

(defn add-all
  "Add all elements to the heap. May be more efficient than adding one by one."
  [heap elements]
  (array/push (heap :content) ;elements)
  (reconstruct heap))

(defn make-heap
  "Create a heap with given elements, can specify `sort-fn` (default `<`) and `key-fn` (default `identity`)."
  [elements &named sort-fn key-fn]
  (let [sort-fn (or sort-fn <)
        key-fn (or key-fn identity)
        result @{:content @[]
                 :sort-fn sort-fn
                 :key-fn key-fn}]
    (add-all result elements)
    result))

(defn add
  "Add an item to the heap."
  [heap item]
  (def content (heap :content))
  (def last-pos (length content))
  (array/push content item)
  (sift-up heap last-pos))

(defn peek
  "Return root of the heap (smallest key with default `<` as key function)."
  [heap]
  (def content (heap :content))
  (unless (empty? content)
    (content 0)))

(defn pop
  "Remove root of the heap and return it."
  [heap]
  (def content (heap :content))
  (unless (empty? content)
    (def res (content 0))
    (set (content 0) (last content))
    (array/pop content)
    (sift-down heap 0)
    res))

(defn update-key
  "Find first element that satisfies the `pred` and replace it with value returned by `(update-fn element)`."
  [heap pred update-fn]
  (let [content (heap :content)
        pos (find-index pred (heap :content))]
    (when pos
      (def old (content pos))
      (def updated (update-fn old))
      (set (content pos) updated)
      (if (compare heap old updated)
        (sift-down heap pos)
        (sift-up heap pos))
      updated)))

(defn drain
  "Pop all elements in heap into an array and returns it. The heap is left empty."
  [heap]
  (def res @[])
  (while (peek heap)
    (array/push res (pop heap)))
  res)

(defn empty-heap?
  "Return true if the heap is empty, false otherwise."
  [heap]
  (empty? (heap :content)))

(defn merge-heaps
  "Merge heap into the first one. Returns first heap."
  [& heaps]
  (unless (= ;(map (fn [h] [(h :sort-fn) (h :key-fn)]) heaps))
    (error "Attemtped to merge incompatible heaps (key-fn and sort-fn must be the same for all heaps)."))
  (apply array/concat (map |($ :content) heaps))
  (let [heap1 (first heaps)]
    (reconstruct heap1)
    heap1))
