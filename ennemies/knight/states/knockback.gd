extends State

const KNOCKBACK_SPEED: float = 400
var knockback_force: float

var knockback_direction := Vector2()

func enter(_msg: Dictionary = {}) -> void:
	owner.play_animation("knockback")

	knockback_force = KNOCKBACK_SPEED
	knockback_direction = (Global.player.position - owner.position).normalized() * -1


func exit() -> void:
	owner.is_hit = false


func physics_process(_delta: float) -> void:
	knockback_force = lerpf(knockback_force, 0.0 , .1)

	if knockback_force < 1:
		_state_machine.transition_to("Idle")
		return
		
	owner.pivot.scale.x = knockback_direction.x * -1
	owner.set_velocity(knockback_direction * knockback_force)
	owner.set_up_direction(Vector2.UP)
	owner.move_and_slide()
