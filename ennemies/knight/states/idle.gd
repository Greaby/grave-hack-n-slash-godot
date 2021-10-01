extends State

func enter(_msg: Dictionary = {}) -> void:
	owner.play_animation("idle")


func physics_process(_delta: float) -> void:
	if is_instance_valid(Global.player):
		_state_machine.transition_to("Chase")
		return

	if owner.hit:
		_state_machine.transition_to("Knockback")
		return
	
	var input_direction = (Global.player.position - owner.position).normalized()
	owner.pivot.scale.x = input_direction.x
