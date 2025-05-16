(define (problem problem1)
  (:domain warehouse)

  (:objects
    r1 - mover
    l1 - loader
    c1 - crate
    loc1 loc2 loading_bay - location
    g1 - group
  )

  (:init
    (robot_at r1 loc1)
    (robot_at l1 loading_bay)
    (crate_at c1 loc1)
    (= (weight c1) 40)
    (= (distance loc1 loading_bay) 10)
    (= (battery r1) 100)
    (loading_bay_free)
  )

  (:goal
    (loaded c1)
  )
)
