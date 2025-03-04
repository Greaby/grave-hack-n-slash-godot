extends Node2D

const rect_positions = [0, 16, 32]


@onready var sprite = $Sprite2D


func _ready() -> void:
	sprite.region_rect.position.x = rect_positions[randi() % rect_positions.size()]
