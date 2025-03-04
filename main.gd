extends Node2D


func _ready() -> void:
	# TEMP
	$Knight.connect("die", Callable(Global, "update_kills"))
	$Knight.connect("die", Callable(self, "emit_xp").bind($Knight))


func emit_xp(ennemi) -> void:
	for i in ennemi.XP:
		var orb = load("res://player/experience_orb.tscn").instantiate()
		orb.global_position = ennemi.center.global_position
		add_child(orb)
