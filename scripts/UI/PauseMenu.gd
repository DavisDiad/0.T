extends Control


var current_language = "en"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_language = DialogueManager.current_language
	refresh_ui_language()
	
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
	refresh_ui_language()

func on_pt_pressed():
	DialogueManager.game_language("pt")
	DialogueManager.refresh_current_dialogue()
	refresh_ui_language()

func refresh_ui_language():
	$SoundPanel/SoundButton.text = TranslationManager.get_text("sound")
	$"../UIButtons/ReturnTexture/ReturnButton".text = TranslationManager.get_text("return")

	$"../UIOptions/SpeakTexture/SpeakButton".text = TranslationManager.get_text("speak")
	$"../UIOptions/HurtTexture/HurtButton".text = TranslationManager.get_text("hurt")
	$"../UIOptions/HealTexture/HealButton".text = TranslationManager.get_text("heal")
	$"../UIOptions/KillTexture/KillButton".text = TranslationManager.get_text("kill")
	
	$"../Book/TitlePanel/TitleTextLabel".text = TranslationManager.get_text("infected_one")
	$"../Book/WiresTextLabel".text = TranslationManager.get_text("wires")
	$"../Book/CablesTextLabel".text = TranslationManager.get_text("cabless")
