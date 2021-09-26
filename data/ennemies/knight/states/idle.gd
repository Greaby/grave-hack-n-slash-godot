extends State

func enter(_msg: Dictionary = {}) -> void:
	owner.play_animation("idle")


func physics_process(_delta: float) -> void:
	if is_instance_valid(Global.skeleton):
		_state_machine.transition_to("Chase")
		return

	if owner.hit:
		_state_machine.transition_to("Knockback")
		return
