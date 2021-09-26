extends Position2D

var weight := 0.2

onready var player = get_node("../Player")


func _process(delta: float) -> void:
	if not is_instance_valid(player):
		return
	
	var taget_position := Vector2()
	
	taget_position.x = int(lerp(global_position.x, player.global_position.x, weight))
	taget_position.y = int(lerp(global_position.y, player.global_position.y, weight))
	
	global_position = taget_position


	
