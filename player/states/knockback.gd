extends State

const KNOCKBACK_SPEED = 400
var knockback_force


func enter(_msg: Dictionary = {}) -> void:
	owner.play_animation("knockback")

	knockback_force = KNOCKBACK_SPEED


func exit() -> void:
	owner.hit = false


func physics_process(_delta: float) -> void:
	knockback_force = lerp(knockback_force, 0 , .1)

	if knockback_force < 1:
		_state_machine.transition_to("Idle")
		return
		
	owner.pivot.scale.x = owner.hit_direction.x * -1
	owner.move_and_slide(owner.hit_direction * knockback_force, Vector2.UP)
