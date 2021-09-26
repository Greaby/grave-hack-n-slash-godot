extends Node
class_name State

onready var _state_machine: = _get_state_machine(self)


func unhandled_input(_event: InputEvent) -> void:
	return


func physics_process(_delta: float) -> void:
	return


func enter(_msg: Dictionary = {}) -> void:
	return


func exit() -> void:
	return


func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node
