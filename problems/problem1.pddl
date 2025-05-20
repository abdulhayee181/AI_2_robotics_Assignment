(define (problem problem1)
  (:domain warehouse)

  (:objects
    r1 r2 - mover
    l1 - loader
    c1 c2 c3 - crate
    loading_bay loc1 loc2 loc3 - location
    gA - group
  )

  (:init
    ;; Robots start at loading bay
    (robot_at r1 loading_bay)
    (robot_at r2 loading_bay)
    (robot_at l1 loading_bay)

    ;; Crates at respective locations
    (crate_at c1 loc1)
    (crate_at c2 loc2)
    (crate_at c3 loc3)

    ;; Weights
    (= (weight c1) 70)
    (= (weight c2) 20)
    (= (weight c3) 20)

    ;; Fragility
    (fragile c2)

    ;; Group membership
    (in_group c2 gA)
    (in_group c3 gA)

    ;; Distances (symmetric)
    (= (distance loading_bay loc1) 10)
    (= (distance loc1 loading_bay) 10)

    (= (distance loading_bay loc2) 20)
    (= (distance loc2 loading_bay) 20)

    ; (= (distance loading_bay loc3) 20)
    ; (= (distance loc3 loading_bay) 20)

    (loading_bay_free)
  )

  (:goal
    (and
      (loaded c1)
      (loaded c2)
      (loaded c3)
    )
  )
)
