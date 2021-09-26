extends KinematicBody2D

export (int) var life
export (int) var speed = 100

var input_direction = Vector2()

onready var animated_sprite = $Pivot/AnimatedSprite
onready var pivot = $Pivot
onready var attack_one = $Pivot/Attacks/AttackOne
onready var attack_two = $Pivot/Attacks/AttackTwo
onready var attack_three = $Pivot/Attacks/AttackThree

func _ready() -> void:
	Global.skeleton = self


func play_animation(name: String) -> void:
	animated_sprite.frame = 0
	animated_sprite.play(name)


func _physics_process(delta: float) -> void:
	input_direction.x = (int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")))


func damage(amount) -> void:
	life -= amount
	if life <= 0:
		queue_free()
