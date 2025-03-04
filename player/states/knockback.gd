extends State

const KNOCKBACK_SPEED = 400.0
var knockback_force:float = 0.0


func enter(_msg: Dictionary = {}) -> void:
	owner.play_animation("knockback")

	knockback_force = KNOCKBACK_SPEED


func exit() -> void:
	owner.is_hit = false


func physics_process(_delta: float) -> void:
	knockback_force = lerpf(knockback_force, 0.0 , 0.1)

	if knockback_force < 1:
		_state_machine.transition_to("Idle")
		return
		
	owner.pivot.scale.x = owner.hit_direction.x * -1
	owner.set_velocity(owner.hit_direction * knockback_force)
	owner.set_up_direction(Vector2.UP)
	owner.move_and_slide()
