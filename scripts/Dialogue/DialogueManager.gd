extends Node


signal dialogue_requested(dialogue_text, options, speech_sfx)


var dialogue_data = {}
var current_language = "en"
var current_dialogue_id = ""


var sfx: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open("res://scripts/Dialogue/dialogue.json", FileAccess.READ)
	var json_text = file.get_as_text()
	dialogue_data = JSON.parse_string(json_text)
	


func show_dialogue(dialogue_id: String, speech_sfx: AudioStream = null):
	current_dialogue_id = dialogue_id
	
	var dialogue = dialogue_data[dialogue_id]
	var text = dialogue["text"][current_language]
	var options = dialogue["options"]
	
	dialogue_requested.emit(text,options, speech_sfx)
