extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control/PlayPanel/PlayButton.connect("tween_finished", on_play_pressed)

func on_play_pressed():
	PollutionManager._ready()
	
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/intro.tscn")
