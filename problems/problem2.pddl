(define (problem problem2)
  (:domain warehouse)

  (:objects
    r1 r2 - mover
    l1 - loader
    c1 c2 c3 c4 - crate
    loading_bay loc1 loc2 - location
    gA gB - group
  )

  (:init
    ;; Robots at the loading bay
    (robot_at r1 loading_bay)
    (robot_at r2 loading_bay)
    (robot_at l1 loading_bay)

    ;; Crate locations
    (crate_at c1 loc1)
    (crate_at c2 loc2)
    (crate_at c3 loc2)
    (crate_at c4 loc1)

    ;; Weights
    (= (weight c1) 70)
    (= (weight c2) 80)
    (= (weight c3) 20)
    (= (weight c4) 30)

    ;; Fragile
    (fragile c2)

    ;; Group membership
    (in_group c1 gA)
    (in_group c2 gA)
    (in_group c3 gB)
    (in_group c4 gB)

    ;; Distances
    (= (distance loading_bay loc1) 10)
    (= (distance loc1 loading_bay) 10)

    (= (distance loading_bay loc2) 20)
    (= (distance loc2 loading_bay) 20)

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
