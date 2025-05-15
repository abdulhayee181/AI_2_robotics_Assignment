(define (problem warehouse-0.5)
  (:domain warehouse)
  
  (:objects
    m1 m2 - mover
    l1 - loader
    c1 c2 - crate
    loading_bay - location
    loc1 loc2 - location
    groupA - group
  )
  
  (:init
    ;; Robot initial positions
    (at m1 loading_bay)
    (at m2 loading_bay)
    (at l1 loading_bay)
    (can_load_heavy l1)  ; Only one loader that can handle heavy crates
    
    ;; Crate positions and properties
    (crate_at c1 loc1)
    (crate_at c2 loc2)
    (= (weight c1) 70)
    (= (weight c2) 20)
    
    ;; Distances
    (= (distance loc1 loading_bay) 10)
    (= (distance loc2 loading_bay) 20)
    
    ;; Extension 1: Grouped crates
    (in_group c2 groupA)
    (= (group_of c2) groupA)
    
    ;; Extension 3: Battery initialization
    (= (battery m1) 20)
    (= (battery m2) 20)
    
    ;; System state
    (loading_bay_free)
    (= (total_time) 0)
  )
  
  (:goal (and
    (loaded c1)
    (loaded c2)
  )))