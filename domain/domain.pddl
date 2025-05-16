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

  ;; movers can move alone without crate
  (:action move_mover
    :parameters (?m - mover ?from - location ?to - location)
    :precondition (robot_at ?m ?from)
    :effect (and
      (not (robot_at ?m ?from))
      (robot_at ?m ?to)
      (increase (total_time) (distance ?from ?to))
    )
  )

  (:action move_single
    :parameters (?m - mover ?from - location ?to - location ?c - crate)
    :precondition (and
      (robot_at ?m ?from)
      (crate_at ?c ?from)
      (<= (weight ?c) 50)
      (not (fragile ?c))
      (or (not (= ?to loading_bay)) (loading_bay_free))
    )
    :effect (and
      (not (robot_at ?m ?from))
      (robot_at ?m ?to)
      (not (crate_at ?c ?from))
      (crate_at ?c ?to)
      (increase (total_time) (/ (* (distance ?from ?to) (weight ?c)) 100))
    )
  )

  (:action move_double
    :parameters (?m1 - mover ?m2 - mover ?from - location ?to - location ?c - crate)
    :precondition (and
      (robot_at ?m1 ?from)
      (robot_at ?m2 ?from)
      (crate_at ?c ?from)
      (or (> (weight ?c) 50) (fragile ?c))
      (or (not (= ?to loading_bay)) (loading_bay_free))
    )
    :effect (and
      (not (robot_at ?m1 ?from))
      (not (robot_at ?m2 ?from))
      (robot_at ?m1 ?to)
      (robot_at ?m2 ?to)
      (not (crate_at ?c ?from))
      (crate_at ?c ?to)
      (increase (total_time) (/ (* (distance ?from ?to) (weight ?c)) 100))
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
