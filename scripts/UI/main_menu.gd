extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control/PlayPanel/PlayButton.connect("tween_finished", on_play_pressed)
	$Control/EnPanel/EnButton.connect("tween_finished", on_en_pressed)
	$Control/PtPanel/PtButton.connect("tween_finished", on_pt_pressed)
	$Control/QuitPanel/QuitButton.connect("tween_finished", on_quit_pressed)

func on_play_pressed():
	PollutionManager._ready()
	
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/intro.tscn")

func on_en_pressed():
	DialogueManager.game_language("en")
	DialogueManager.refresh_current_dialogue()
	refresh_ui_language()

func on_pt_pressed():
	DialogueManager.game_language("pt")
	DialogueManager.refresh_current_dialogue()
	refresh_ui_language()

func on_quit_pressed():
	get_tree().quit()

func refresh_ui_language():
	$Control/PlayPanel/PlayButton.text = TranslationManager.get_text("play")
	$Control/QuitPanel/QuitButton.text = TranslationManager.get_text("quit")
