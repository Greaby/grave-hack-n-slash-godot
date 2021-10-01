extends Node2D


func _ready() -> void:
	# TEMP
	$Knight.connect("die", Global, "update_kills")
