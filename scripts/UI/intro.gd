extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VideoStreamPlayer.connect("finished", on_video_finished)
	

func on_video_finished():
	get_tree().change_scene_to_file("res://scenes/bunker.tscn")
	Transition.fade_to_normal()
