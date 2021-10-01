extends CanvasLayer


onready var health_bar = $HealthBar
onready var tween = $Tween

onready var killsLabel = $HBoxContainer/kills
onready var levelLabel = $HBoxContainer/Level


func _ready() -> void:
	Global.connect("kills_changed", self, "update_kills")
	Global.player.connect("hit", self, "update_health")


func update_health(value) -> void:
	tween.interpolate_property(health_bar, "value", health_bar.value, value, 0.6, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()


func update_kills(value) -> void:
	killsLabel.text = "Kills : " + str(value)


func update_level(value) -> void:
	levelLabel.text = "Level : " + str(value)
