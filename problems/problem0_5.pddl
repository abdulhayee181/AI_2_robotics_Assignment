(define (problem problem0_5)
  (:domain warehouse)

  (:objects
    r2 r1 - mover
    l1 - loader
    c1 c2 - crate
    loading_bay loc1 loc2 - location
    gA - group
  )

  (:init
    (robot_at r1 loading_bay)
    (robot_at l1 loading_bay)
    (robot_at r2 loading_bay)

    (crate_at c1 loc1)
    (crate_at c2 loc2)

    ;; Set numeric fluent values instead of predicates
    (= (weight c1) 70)
    (= (weight c2) 20)

    (= (distance loading_bay loc1) 10)
    (= (distance loading_bay loc2) 20)
    (= (distance loc1 loading_bay) 10)
    (= (distance loc2 loading_bay) 20)

    (in_group c2 gA)

    (loading_bay_free)
  )

  (:goal
    (and
      (loaded c1)
      (loaded c2)
    )
  )
)
