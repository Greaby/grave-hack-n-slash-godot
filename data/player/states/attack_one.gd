extends State

var attack_finished = false

func enter(_msg: Dictionary = {}) -> void:
	attack_finished = false
	owner.play_animation("attack_one")
	owner.attack_one.attack()
	
	yield(owner.animated_sprite, "animation_finished")
	attack_finished = true


func exit() -> void:
	owner.attack_one.idle()


func physics_process(_delta: float) -> void:
	if(Input.is_action_just_pressed("attack")):
		_state_machine.transition_to("AttackTwo")
		return
	
	if attack_finished:
		_state_machine.transition_to("Idle")
		return
		
	if(owner.animated_sprite.frame == 2):
		owner.attack_one.idle()
