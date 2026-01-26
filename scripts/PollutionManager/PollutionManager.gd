extends Node

signal pollution_state_1
signal pollution_state_2
signal pollution_state_3

var pollution_meter := 15

var pollution_state := 0


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

func add_pollution(INT):
	pollution_meter += INT
	print(pollution_meter)
	
	if pollution_meter >= 55:
		pollution_state = 1
		pollution_state_1.emit()
	
		if pollution_meter >= 75:
			pollution_state = 2
			pollution_state_2.emit()
	
			if pollution_meter >= 100:
				pollution_state = 3
				pollution_state_3.emit()
	
	print(pollution_state)
