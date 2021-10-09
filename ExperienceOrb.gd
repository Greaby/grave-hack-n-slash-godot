extends Node2D

const SPEED = 1000

const XP = 1

var velocity := Vector2()


func _ready() -> void:
	velocity = Vector2(rand_range(-1.0, 1.0), rand_range(-1.0, 0.2))


func _physics_process(delta: float) -> void:
	position += velocity * SPEED * delta
	
	if is_instance_valid(Global.player) :
		var player_position = Global.player.global_position + Vector2(0, -100)
		
		var steering = lerp(velocity, global_position.direction_to(player_position), 0.01)
		velocity = steering
	else:
		queue_free()


func _on_Area2D_body_entered(body: Node) -> void:
	Global.add_xp(XP)
	queue_free()
