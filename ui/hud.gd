extends CanvasLayer


onready var health_bar = $HealthBar
onready var tween = $Tween

onready var killsLabel = $HBoxContainer/kills
onready var levelLabel = $HBoxContainer/Level


func _ready() -> void:
	Global.connect("kills_changed", self, "on_kills_changed")
	Global.connect("level_changed", self, "on_level_changed")
	Global.player.connect("hit", self, "update_health")


func update_health(value) -> void:
	tween.interpolate_property(health_bar, "value", health_bar.value, value, 0.6, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()


func on_kills_changed(value) -> void:
	killsLabel.text = "Kills : " + str(value)


func on_level_changed() -> void:
	levelLabel.text = "Level : " + str(Global.level)
