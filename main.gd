extends Node2D


func _ready() -> void:
	# TEMP
	$Knight.connect("die", Global, "update_kills")
	$Knight.connect("die", self, "emit_xp", [$Knight])


func emit_xp(ennemi) -> void:
	for i in ennemi.XP:
		var orb = load("res://player/experience_orb.tscn").instance()
		orb.global_position = ennemi.center.global_position
		add_child(orb)
