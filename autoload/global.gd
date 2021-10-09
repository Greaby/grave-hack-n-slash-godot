extends Node

signal kills_changed(value)
signal level_changed

const XP_LEVEL_UP := 9

var player

var kills = 0
var xp := 0
var level := 1

func _ready() -> void:
	randomize()


func update_kills() -> void:
	kills += 1
	emit_signal("kills_changed", kills)


func add_xp(value):
	xp += value
	if xp == XP_LEVEL_UP:
		xp = 0
		level += 1
		emit_signal("level_changed")
