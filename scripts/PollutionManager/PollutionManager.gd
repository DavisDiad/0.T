extends Node

signal pollution_state_1
signal pollution_state_2
signal pollution_state_3

var pollution_meter := 15

var pollution_state := 0


func _ready() -> void:
	pollution_state = 0
	pollution_meter = 15

func apply_action(action):
	match action:
		"speak":
			add_pollution(3)
		"hurt":
			add_pollution(5)
		"heal":
			add_pollution(2)
		"healed":
			add_pollution(-10)
		"option":
			add_pollution(2)

func add_pollution(value):
	pollution_meter += value

	var new_state := pollution_state

	if pollution_meter >= 100:
		new_state = 3
	elif pollution_meter >= 75:
		new_state = 2
	elif pollution_meter >= 55:
		new_state = 1
	else:
		new_state = 0

	if new_state != pollution_state:
		pollution_state = new_state
		emit_state_signal(new_state)

func emit_state_signal(state):
	match state:
		1:
			pollution_state_1.emit()
		2:
			pollution_state_2.emit()
		3:
			pollution_state_3.emit()
