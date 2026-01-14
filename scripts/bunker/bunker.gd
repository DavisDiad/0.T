extends Node3D

var hovering = false

var pollution_meter = 35

signal show_options

var cursor_default = preload("res://placeholders/cursor3.png")
var cursor_hover = preload("res://placeholders/cursor_hover.png")
const CURSOR_HOVER = preload("uid://bm5yc3i617ocu")

func _ready() -> void:
	Input.set_custom_mouse_cursor(CURSOR_HOVER, Input.CURSOR_POINTING_HAND)

func _process(_delta: float) -> void:
	if pollution_meter == 100 or pollution_meter > 100:
		print ("game over")


func _on_character1_mouse_entered() -> void:
	$UISounds/Hover.play()
	hovering = true
	Input.set_custom_mouse_cursor(cursor_hover, Input.CURSOR_ARROW)

func _on_character1_mouse_exited() -> void:
	hovering = false
	Input.set_custom_mouse_cursor(cursor_default, Input.CURSOR_ARROW)

func _on_character1_input_event(_camera: Node, _event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if hovering == true and Input.is_action_just_pressed("left_click"):
		$UISounds/Click.play()
		show_options.emit()
		pollution_meter += 1
