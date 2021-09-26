extends State

var attack_finished = false

func enter(_msg: Dictionary = {}) -> void:
	attack_finished = false
	owner.play_animation("attack_three")

	yield(owner.animated_sprite, "animation_finished")
	attack_finished = true


func exit() -> void:
	owner.attack_three.idle()


func physics_process(_delta: float) -> void:
	if attack_finished:
		_state_machine.transition_to("Idle")
		return

	if(owner.animated_sprite.frame == 2):
		owner.attack_three.attack()
		
	if(owner.animated_sprite.frame == 4):
		owner.attack_three.idle()
