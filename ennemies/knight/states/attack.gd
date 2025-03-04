extends State

var attack_finished = false


func enter(_msg: Dictionary = {}) -> void:
	attack_finished = false
	owner.play_animation("attack")
	
	await owner.animated_sprite.animation_finished
	attack_finished = true


func exit() -> void:
	owner.attack.idle()


func physics_process(_delta: float) -> void:
	if owner.is_hit:
		_state_machine.transition_to("Knockback")
		return
	
	if attack_finished:
		_state_machine.transition_to("Idle")
		return

	if(owner.animated_sprite.frame == 4):
		owner.attack.attack()
	if(owner.animated_sprite.frame == 6):
		owner.attack.idle()
