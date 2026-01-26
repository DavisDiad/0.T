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
	

func game_language(language):
	match language:
		"en":
			current_language ="en"
		"pt":
			current_language ="pt"

func show_dialogue(dialogue_id: String, speech_sfx: AudioStream = null):
	current_dialogue_id = dialogue_id
	
	var dialogue = dialogue_data[dialogue_id]

	var text = dialogue["text"][current_language]
	var raw_options = dialogue["options"]

	var localized_options = null

	if raw_options != null:
		localized_options = {}

		for key in raw_options.keys():
			localized_options[key] = {
				"text": raw_options[key]["text"][current_language],
				"next": raw_options[key]["next"]
			}

	dialogue_requested.emit(text, localized_options, speech_sfx)

func refresh_current_dialogue():
	if current_dialogue_id == "":
		return

	show_dialogue(current_dialogue_id, sfx)
