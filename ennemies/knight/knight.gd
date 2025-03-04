extends CharacterBody2D

signal die

const XP = 6

@export var life: int = 100
@export var speed: int = 80
@export var attack_range: int = 168

var is_hit := false

@onready var animated_sprite = $Pivot/AnimatedSprite2D
@onready var pivot = $Pivot
@onready var attack = $Pivot/Attack
@onready var center = $Pivot/Center


func play_animation(animation_name: String) -> void:
	animated_sprite.frame = 0
	animated_sprite.play(animation_name)


func damage(amount, _position):
	is_hit = true
	life -= amount
	if(life <= 0):
		emit_signal("die")
		queue_free()
