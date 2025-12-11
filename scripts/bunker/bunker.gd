extends Node3D

var hovering = false

signal show_options

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass


func _on_character1_mouse_entered() -> void:
	hovering = true

func _on_character1_mouse_exited() -> void:
	hovering = false

func _on_character1_input_event(_camera: Node, _event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if hovering == true and Input.is_action_just_pressed("left_click"):
		show_options.emit()


func _on_character2_mouse_entered() -> void:
	hovering = true


func _on_character2_mouse_exited() -> void:
	hovering = false
