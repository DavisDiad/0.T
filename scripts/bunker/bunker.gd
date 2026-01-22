extends Node3D

signal talking_to_npc

var hovering = false

var pollution_meter = 35

var cursor_default = preload("res://placeholders/cursor3.png")
var cursor_hover = preload("res://placeholders/cursor_hover.png")

const CURSOR_HOVER = preload("uid://bm5yc3i617ocu")

func _ready() -> void:
	$UI.connect("show_character_on_bunker", show_character_here)
	
	Input.set_custom_mouse_cursor(CURSOR_HOVER, Input.CURSOR_POINTING_HAND)
	
	$Character1/Area3D.connect("input_event", talk_to_aeiln)
	
	$Character1/Area3D.connect("mouse_entered", hover_cursor)
	$Character1/Area3D.connect("mouse_exited", default_cursor)
	

func _process(_delta: float) -> void:
	if pollution_meter == 100 or pollution_meter > 100:
		print ("game over")


func talk_to_aeiln(_camera: Node, _event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if hovering == true and Input.is_action_just_pressed("left_click"):
		emit_signal("talking_to_npc")
		pollution_meter += 1
		$Character1.visible = false


func hover_cursor() -> void:
	hovering = true
	Input.set_custom_mouse_cursor(cursor_hover, Input.CURSOR_ARROW)

func default_cursor() -> void:
	hovering = false
	Input.set_custom_mouse_cursor(cursor_default, Input.CURSOR_ARROW)


func show_character_here() -> void:
	$Character1.visible = true
