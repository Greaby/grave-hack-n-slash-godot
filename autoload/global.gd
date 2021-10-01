extends Node

signal kills_changed(value)

var player

var kills = 0

func _ready() -> void:
	randomize()


func update_kills() -> void:
	kills += 1
	emit_signal("kills_changed", kills)
