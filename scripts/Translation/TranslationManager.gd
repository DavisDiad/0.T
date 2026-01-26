extends Node

var ui_data = {}
var current_language = "en"

func _ready():
	var file = FileAccess.open("res://scripts/Translation/ui_text.json", FileAccess.READ)
	ui_data = JSON.parse_string(file.get_as_text())


func get_text(key: String) -> String:
	current_language = DialogueManager.current_language
	if ui_data.has(key):
		return ui_data[key][current_language]

	return key
