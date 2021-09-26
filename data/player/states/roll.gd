extends State

const ROLL_SPEED = 600

var roll_direction = 0
var roll_finished = false

func enter(_msg: Dictionary = {}) -> void:
	roll_finished = false
	roll_direction = owner.pivot.scale.x
	owner.play_animation("roll")
	
	yield(owner.animated_sprite, "animation_finished")
	roll_finished = true


func physics_process(_delta: float) -> void:
	if roll_finished:
		_state_machine.transition_to("Idle")
		return

	owner.move_and_slide(Vector2(roll_direction * ROLL_SPEED, 0))
