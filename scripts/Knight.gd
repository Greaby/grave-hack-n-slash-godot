extends "res://scripts/Character.gd"

const UP = Vector2(0, -1)

enum STATES { CHASE, ATTACK, KNOCKBACK }

var state = null

export (int) var speed = 20
export (int) var attack_range = 42

var knockback_speed = 100

func _ready():
	_change_state(STATES.CHASE)

func _change_state(new_state):
	
	$Pivot/Attack.idle()
	
	match new_state:
		STATES.CHASE:
			$Pivot/AnimatedSprite.play("walk")
		STATES.ATTACK:
			$Pivot/AnimatedSprite.play("attack")
		STATES.KNOCKBACK:
			$Pivot/AnimatedSprite.play("knockback")
			knockback_speed = 100

	state = new_state

func knockback():
	_change_state(STATES.KNOCKBACK)

func _physics_process(delta):
	match state:
		STATES.CHASE:
			if Global.skeleton:
				if(Global.skeleton.position.distance_to(position) <= attack_range):
					_change_state(STATES.ATTACK)
				
				var input_direction = get_input_direction()
				update_look_direction(input_direction)
				move(input_direction)
		STATES.ATTACK:
			if($Pivot/AnimatedSprite.frame == 4):
				$Pivot/Attack.attack()
			if($Pivot/AnimatedSprite.frame == 6):
				$Pivot/Attack.idle()
		STATES.KNOCKBACK:
			var input_direction = get_input_direction() 
			knockback_speed = lerp(knockback_speed, 0 , .1)
			
			update_look_direction(input_direction)
			move_and_slide(input_direction * knockback_speed * -1, UP)
			
			if(knockback_speed < 1):
				_change_state(STATES.CHASE)


func get_input_direction():
	var input_direction = Vector2()
	input_direction = (Global.skeleton.position - position)
	return input_direction.normalized()

func update_look_direction(input_direction):
	if(input_direction.x):
		$Pivot.scale.x = input_direction.normalized().x
		
func move(input_direction):
	move_and_slide(input_direction * speed, UP)

func on_animation_finished():
	if(["attack"].has($Pivot/AnimatedSprite.animation)):
		_change_state(STATES.CHASE)

