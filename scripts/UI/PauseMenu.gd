extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MenuPanel/MenuButton.connect("tween_finished", on_menu_pressed)
	
	$SoundPanel/SoundButton.connect("tween_finished", on_sound_pressed)
	
	$EnPanel/EnButton.connect("tween_finished", on_en_pressed)
	
	$PtPanel4/PtButton.connect("tween_finished", on_pt_pressed)

func on_menu_pressed():
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func on_sound_pressed():
	pass

func on_en_pressed():
	DialogueManager.game_language("en")
	DialogueManager.refresh_current_dialogue()

func on_pt_pressed():
	DialogueManager.game_language("pt")
	DialogueManager.refresh_current_dialogue()
