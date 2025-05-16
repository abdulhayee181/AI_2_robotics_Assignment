(define (problem problem3)
  (:domain warehouse)

  (:objects
    r1 r2 - mover
    l1      - loader
    c1 c2 c3 c4 - crate
    loading_bay loc1 loc2 loc3 loc4 - location
    gA      - group
  )

  (:init
    ;; Robots at loading bay
    (robot_at r1 loading_bay)
    (robot_at r2 loading_bay)
    (robot_at l1 loading_bay)

    ;; Crates at locations
    (crate_at c1 loc1)
    (crate_at c2 loc2)
    (crate_at c3 loc3)
    (crate_at c4 loc4)

    ;; Weights
    (= (weight c1) 70)
    (= (weight c2) 80)
    (= (weight c3) 60)
    (= (weight c4) 30)

    ;; Fragility
    (fragile c2)

    ;; Group membership
    (in_group c1 gA)
    (in_group c2 gA)
    (in_group c3 gA)

    ;; Distances (symmetric)
    (= (distance loading_bay loc1) 20)
    (= (distance loc1 loading_bay) 20)

    (= (distance loading_bay loc2) 20)
    (= (distance loc2 loading_bay) 20)

    (= (distance loading_bay loc3) 30)
    (= (distance loc3 loading_bay) 30)

    (= (distance loading_bay loc4) 10)
    (= (distance loc4 loading_bay) 10)

    ;; Loading bay initially free
    (loading_bay_free)
  )

  (:goal
    (and
      (loaded c1)
      (loaded c2)
      (loaded c3)
      (loaded c4)
    )
  )
)
