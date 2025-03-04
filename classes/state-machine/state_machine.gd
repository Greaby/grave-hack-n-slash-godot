extends Node
class_name StateMachine

@export var initial_state: = NodePath()

@onready var state: State = get_node(initial_state): set = set_state
@onready var _state_name: = state.name

var process = true

func _init() -> void:
	add_to_group("state_machine")


func _ready() -> void:
	await owner.ready
	state.enter()


func _unhandled_input(event: InputEvent) -> void:
	state.unhandled_input(event)


func _physics_process(delta: float) -> void:
	if not process:
		return
	state.call_deferred("physics_process", delta)


func transition_to(target_state_path: String, msg: Dictionary = {}) -> void:
	process = false
	if not has_node(target_state_path):
		return
	
	var target_state = get_node(target_state_path)
	
	state.exit()
	self.state = target_state
	state.enter(msg)
	process = true


func set_state(value: State) -> void:
	state = value
	_state_name = value.name
