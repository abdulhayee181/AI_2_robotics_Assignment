(define (problem problem4)
  (:domain warehouse)

  (:objects
    r1 r2 - mover
    l1      - loader
    c1 c2 c3 c4 c5 c6 - crate
    loading_bay loc1 loc2 loc3 loc4 loc5 loc6 - location
    gA gB   - group
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
    (crate_at c5 loc5)
    (crate_at c6 loc6)

    ;; Weights
    (= (weight c1) 30)
    (= (weight c2) 20)
    (= (weight c3) 30)
    (= (weight c4) 20)
    (= (weight c5) 30)
    (= (weight c6) 20)

    ;; Fragile
    (fragile c2)
    (fragile c3)
    (fragile c4)
    (fragile c5)

    ;; Group memberships
    (in_group c1 gA)
    (in_group c2 gA)
    (in_group c3 gB)
    (in_group c4 gB)
    (in_group c5 gB)

    ;; Distances (symmetric)
    (= (distance loading_bay loc1) 20)
    (= (distance loc1 loading_bay) 20)

    (= (distance loading_bay loc2) 20)
    (= (distance loc2 loading_bay) 20)

    (= (distance loading_bay loc3) 10)
    (= (distance loc3 loading_bay) 10)

    (= (distance loading_bay loc4) 20)
    (= (distance loc4 loading_bay) 20)

    (= (distance loading_bay loc5) 30)
    (= (distance loc5 loading_bay) 30)

    (= (distance loading_bay loc6) 10)
    (= (distance loc6 loading_bay) 10)

    ;; Loading bay initially free
    (loading_bay_free)
  )

  (:goal
    (and
      (loaded c1)
      (loaded c2)
      (loaded c3)
      (loaded c4)
      (loaded c5)
      (loaded c6)
    )
  )
)
