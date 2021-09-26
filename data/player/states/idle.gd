extends State

func enter(_msg: Dictionary = {}) -> void:
	owner.play_animation("idle")


func physics_process(_delta: float) -> void:
	if(Input.is_action_just_pressed("roll")):
		_state_machine.transition_to("Roll")
		return
	
	if(Input.is_action_just_pressed("attack")):
		_state_machine.transition_to("AttackOne")
		return
	
	if owner.input_direction.length() != 0:
		_state_machine.transition_to("Move")
		return
