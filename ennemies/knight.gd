extends KinematicBody2D

signal die

export (int) var life = 100
export (int) var speed = 80
export (int) var attack_range = 168

var hit := false

onready var animated_sprite = $Pivot/AnimatedSprite
onready var pivot = $Pivot
onready var attack = $Pivot/Attack


func play_animation(name: String) -> void:
	animated_sprite.frame = 0
	animated_sprite.play(name)


func damage(amount, _position):
	hit = true
	life -= amount
	if(life <= 0):
		emit_signal("die")
		queue_free()
