extends "res://scripts/Character.gd"

const UP = Vector2(0, -1)

export var speed = 100

var motion = Vector2()

enum STATES { IDLE, MOVE, ROLL, ATTACK_ONE, ATTACK_TWO, ATTACK_THREE }

var state = null

func _ready():
	Global.skeleton = self
	_change_state(STATES.IDLE)
	
func _change_state(new_state):
	var current_state = state
	
	for attack in $Pivot/Attacks.get_children():
		attack.idle()

	match new_state:
		STATES.IDLE:
			$Pivot/AnimatedSprite.play("idle")
		STATES.MOVE:
			$Pivot/AnimatedSprite.play("run")
		STATES.ROLL:
			$Pivot/AnimatedSprite.play("roll")
		STATES.ATTACK_ONE:
			$Pivot/AnimatedSprite.play("attack_one")
		STATES.ATTACK_TWO:
			$Pivot/AnimatedSprite.play("attack_two")
		STATES.ATTACK_THREE:
			$Pivot/AnimatedSprite.play("attack_three")

	state = new_state
	
func _process(delta):
	if (state == STATES.IDLE or state == STATES.MOVE): 
		if(Input.is_action_just_pressed("roll")):
			return _change_state(STATES.ROLL)
		
		if(Input.is_action_just_pressed("attack")):
			return _change_state(STATES.ATTACK_ONE)

	if(state == STATES.ATTACK_ONE and Input.is_action_just_pressed("attack")):
		return _change_state(STATES.ATTACK_TWO)
		
	if(state == STATES.ATTACK_TWO and Input.is_action_just_pressed("attack")):
		return _change_state(STATES.ATTACK_THREE)
			

func _physics_process(delta):
	var input_direction = get_input_direction()
	
	match state:
		STATES.IDLE:
			if input_direction:
				_change_state(STATES.MOVE)
		STATES.MOVE:
			if(input_direction):
				update_look_direction(input_direction)
				move(input_direction)
			else:
				_change_state(STATES.IDLE)
		STATES.ROLL:
			var direction = $Pivot.scale.x
			input_direction = Vector2(direction * 2, 0)
			move(input_direction)
		STATES.ATTACK_ONE:
			if($Pivot/AnimatedSprite.frame == 0):
				$Pivot/Attacks/AttackOne.attack()
			if($Pivot/AnimatedSprite.frame == 2):
				$Pivot/Attacks/AttackOne.idle()
		STATES.ATTACK_TWO:
			if($Pivot/AnimatedSprite.frame == 1):
				$Pivot/Attacks/AttackTwo.attack()
			if($Pivot/AnimatedSprite.frame == 5):
				$Pivot/Attacks/AttackTwo.idle()
		STATES.ATTACK_THREE:
			if($Pivot/AnimatedSprite.frame == 2):
				$Pivot/Attacks/AttackThree.attack()
			if($Pivot/AnimatedSprite.frame == 4):
				$Pivot/Attacks/AttackThree.idle()
	

func get_input_direction():
	var input_direction = Vector2()
	input_direction.x = (int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")))
	return input_direction


func update_look_direction(input_direction):
	if(input_direction.x):
		$Pivot.scale.x = input_direction.normalized().x
		
func move(input_direction):
	move_and_slide(input_direction * speed, UP)
		


func on_animation_finished():
	if(["roll", "attack_one", "attack_two", "attack_three"].has($Pivot/AnimatedSprite.animation)):
		_change_state(STATES.IDLE)

