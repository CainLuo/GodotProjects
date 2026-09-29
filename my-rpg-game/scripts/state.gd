extends Node

class_name State

var fsm: FSM

func enter_state() -> void:
	pass

func progress_state(delta: float) -> void:
	pass

func exit_state() -> void:
	pass
