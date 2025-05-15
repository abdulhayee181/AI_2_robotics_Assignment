(define (domain warehouse)
  (:requirements 
    :strips 
    :typing 
    :fluents 
    :numeric-fluents
    :durative-actions
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
    ;; Basic predicates
    (robot_at ?r - robot ?l - location)
    (crate_at ?c - crate ?l - location)
    (loaded ?c - crate)
    (loading_bay_free)
    
    ;; Extension predicates
    (in_group ?c - crate ?g - group)
    (next_to_load ?c1 - crate ?c2 - crate)
    (fragile ?c - crate)
    (can_load_heavy ?l - loader)
    (recharging ?m - mover)
  )

  (:functions
    ;; World state
    (weight ?c - crate)
    (distance ?from - location ?to - location)
    (total_time)
    (battery ?r - mover)
    (group_of ?c - crate)
  )

  ;; ====================== MOVEMENT ACTIONS ======================
  (:durative-action move_single
    :parameters (?m - mover ?from - location ?to - location ?c - crate)
    :duration (= ?duration (/ (* (distance ?from ?to) (weight ?c)) 100))
    :condition (and
        (at start (robot_at ?m ?from))
        (at start (crate_at ?c ?from))
        (at start (<= (weight ?c) 50))
        (at start (not (fragile ?c)))
        (at start (>= (battery ?m) ?duration))
        (over all (or (not (= ?to loading_bay)) (loading_bay_free)))
    :effect (and
        (at start (not (robot_at ?m ?from)))
        (at end (robot_at ?m ?to))
        (at start (not (crate_at ?c ?from)))
        (at end (crate_at ?c ?to))
        (decrease (battery ?m) ?duration)
        (increase (total_time) ?duration))
  )

  (:durative-action move_double
    :parameters (?m1 - mover ?m2 - mover ?from - location ?to - location ?c - crate)
    :duration (= ?duration 
        (if (<= (weight ?c) 50)
            (/ (* (distance ?from ?to) (weight ?c)) 150)
            (/ (* (distance ?from ?to) (weight ?c)) 100)))
    :condition (and
        (at start (robot_at ?m1 ?from))
        (at start (robot_at ?m2 ?from))
        (at start (crate_at ?c ?from))
        (at start (or 
            (> (weight ?c) 50)
            (fragile ?c)))
        (at start (>= (battery ?m1) ?duration))
        (at start (>= (battery ?m2) ?duration))
        (over all (or (not (= ?to loading_bay)) (loading_bay_free)))
    :effect (and
        (at start (not (robot_at ?m1 ?from)))
        (at start (not (robot_at ?m2 ?from)))
        (at end (robot_at ?m1 ?to))
        (at end (robot_at ?m2 ?to))
        (at start (not (crate_at ?c ?from)))
        (at end (crate_at ?c ?to))
        (decrease (battery ?m1) ?duration)
        (decrease (battery ?m2) ?duration)
        (increase (total_time) ?duration))
  )

  (:durative-action move_empty
    :parameters (?m - mover ?from - location ?to - location)
    :duration (= ?duration (/ (distance ?from ?to) 10))
    :condition (and
        (at start (robot_at ?m ?from))
        (at start (>= (battery ?m) ?duration))
    :effect (and
        (at start (not (robot_at ?m ?from)))
        (at end (robot_at ?m ?to))
        (decrease (battery ?m) ?duration)
        (increase (total_time) ?duration))
  )

  ;; ====================== LOADING ACTIONS ======================
  (:durative-action load_crate
    :parameters (?l - loader ?c - crate)
    :duration (= ?duration (if (fragile ?c) 6 4))
    :condition (and
        (at start (crate_at ?c loading_bay))
        (at start (loading_bay_free))
        (at start (robot_at ?l loading_bay))
        (at start (or 
            (<= (weight ?c) 50)
            (can_load_heavy ?l)))
        (forall (?other - crate)
            (imply 
                (and (in_group ?other (group_of ?c))
                     (next_to_load ?other ?c))
                (loaded ?other)))
    :effect (and
        (at start (not (loading_bay_free)))
        (at end (loading_bay_free))
        (at end (loaded ?c))
        (at start (not (crate_at ?c loading_bay)))
        (increase (total_time) ?duration))
  )

  ;; ====================== RECHARGE ACTIONS ======================
  (:action start_recharge
    :parameters (?m - mover)
    :precondition (and
        (robot_at ?m loading_bay))
        (not (recharging ?m)))
    :effect (and
        (recharging ?m))
  )

  (:action end_recharge
    :parameters (?m - mover)
    :precondition (and
        (recharging ?m)))
    :effect (and
        (not (recharging ?m))
        (assign (battery ?m) 20))
  )
)))