extends State

func enter(_msg: Dictionary = {}) -> void:
	owner.play_animation("move")


func physics_process(_delta: float) -> void:
	if(owner.is_hit):
		_state_machine.transition_to("Knockback")
		return
	
	if(Input.is_action_just_pressed("roll")):
		_state_machine.transition_to("Roll")
		return
		
	if(Input.is_action_just_pressed("attack")):
		_state_machine.transition_to("AttackOne")
		return
	
	if owner.input_direction.length() == 0:
		_state_machine.transition_to("Idle")
		return

	if(owner.input_direction.x):
		owner.pivot.scale.x = owner.input_direction.normalized().x

	owner.set_velocity(owner.input_direction * owner.speed)
	owner.set_up_direction(Vector2.UP)
	owner.move_and_slide()
