(define (domain warehouse)
  (:requirements 
    :strips 
    :typing 
    :fluents 
    :numeric-fluents
    :action-costs
  )

  (:types
    robot - object
    mover - robot
    loader - robot
    crate - object
    location - object
    group - object
  )

  (:predicates
    (robot_at ?r - robot ?l - location)
    (crate_at ?c - crate ?l - location)
    (loaded ?c - crate)
    (loading_bay_free)
    (in_group ?c - crate ?g - group)
    (fragile ?c - crate)
    (can_load_heavy ?l - loader)
  )

  (:functions
    (weight ?c - crate)
    (distance ?from - location ?to - location)
    (total_time)
  )

  (:durative-action empty_robot_move
      :parameters (?m - mover ?from - location ?to - location)
      :duration (= ?duration (/(distance loading_bay ?to) 10))
      :condition (and 
          (at start ( robot_at ?m ?from 
          ))
          
      )
      :effect (and 
          (at start (not (robot_at ?m ?from)
          ))
          (at end (robot_at ?m ?to
          ))
      )
  )
  
(:durative-action single_mover_trasnport
    :parameters (?m - mover ?from - location ?to - location ?c - crate)
    :duration (= ?duration (/ (* (distance ?from ?to) (weight ?c)) 100))
    :condition (and
        (at start ( crate_at ?c ?from
        ))
        (at start (<= (weight ?c) 50))
        (at start (not (fragile ?c)))
        (at start (or (not (= ?to loading_bay)) (loading_bay_free)))
        (at start (robot_at ?m ?from))
    )
    :effect (and 
        (at start (not (robot_at ?m ?from))
        )
        (at start (not (crate_at ?c ?from)))

        (at end (crate_at ?c ?to))

        
        (at end (robot_at ?m ?to)
        )
    )
)


(:durative-action double_movers_transport
  :parameters (?m1 - mover ?m2 - mover ?from - location ?to - location ?c - crate)
  :duration (= ?duration (/ (* (distance ?from ?to) (weight ?c)) 100))
  :condition (and
    (at start (not (= ?m1 ?m2)))
    (at start (robot_at ?m1 ?from))
    (at start (robot_at ?m2 ?from))
    (at start (crate_at ?c ?from))
    (at start (or (> (weight ?c) 50) (fragile ?c)))
    (at start (or (not (= ?to loading_bay)) (loading_bay_free)))
  )
  :effect (and
    (at start (not (robot_at ?m1 ?from)))
    (at start (not (robot_at ?m2 ?from)))
    (at start (not (crate_at ?c ?from)))

    (at end (robot_at ?m1 ?to))
    (at end (robot_at ?m2 ?to))
    (at end (crate_at ?c ?to))
  )
)


  (:action load
    :parameters (?l - loader ?c - crate ?loc - location)
    :precondition (and
      (robot_at ?l ?loc)
      (crate_at ?c ?loc)
      (= ?loc loading_bay)
      (or (<= (weight ?c) 100) (can_load_heavy ?l))
    )
    :effect (and
      (not (crate_at ?c ?loc))
      (loaded ?c)
      (increase (total_time) 5)
    )
  )

  (:action recharge
    :parameters (?m - mover ?loc - location)
    :precondition (robot_at ?m ?loc)
    :effect (and
      ;; just a placeholder effect
      (increase (total_time) 10)
    )
  )
)
