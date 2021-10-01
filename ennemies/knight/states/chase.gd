extends State

func enter(_msg: Dictionary = {}) -> void:
	owner.play_animation("walk")


func physics_process(_delta: float) -> void:
	if owner.hit:
		_state_machine.transition_to("Knockback")
		return
	
	if not is_instance_valid(Global.player) or not Global.player:
		_state_machine.transition_to("Idle")
		return

	var input_direction = (Global.player.position - owner.position).normalized()
	owner.pivot.scale.x = input_direction.x
	owner.move_and_slide(input_direction * owner.speed, Vector2.UP)
	
	if Global.player and Global.player.position.distance_to(owner.position) <= owner.attack_range:
		_state_machine.transition_to("Attack")
		return
