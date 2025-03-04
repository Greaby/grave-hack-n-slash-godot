extends CanvasLayer


@onready var health_bar = $HealthBar

@onready var killsLabel = $HBoxContainer/kills
@onready var levelLabel = $HBoxContainer/Level


func _ready() -> void:
	Global.connect("kills_changed", Callable(self, "on_kills_changed"))
	Global.connect("level_changed", Callable(self, "on_level_changed"))
	Global.player.connect("hit", Callable(self, "update_health"))


func update_health(value) -> void:
	var tween = create_tween()
	tween.tween_property(health_bar, "value", value, 0.6).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.play()


func on_kills_changed(value) -> void:
	killsLabel.text = "Kills : " + str(value)


func on_level_changed() -> void:
	levelLabel.text = "Level : " + str(Global.level)
