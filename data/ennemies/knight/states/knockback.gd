extends State

const KNOCKBACK_SPEED = 400
var knockback_force

var knockback_direction := Vector2()

func enter(_msg: Dictionary = {}) -> void:
	owner.play_animation("knockback")

	knockback_force = KNOCKBACK_SPEED
	knockback_direction = (Global.skeleton.position - owner.position).normalized() * -1


func exit() -> void:
	owner.hit = false


func physics_process(_delta: float) -> void:
	knockback_force = lerp(knockback_force, 0 , .1)

	if knockback_force < 1:
		_state_machine.transition_to("Idle")
		return
		
	owner.pivot.scale.x = knockback_direction.x * -1
	owner.move_and_slide(knockback_direction * knockback_force, Vector2.UP)
