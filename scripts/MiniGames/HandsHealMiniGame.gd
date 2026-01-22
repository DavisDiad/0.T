extends Control

var hover = false


func _ready() -> void:
	$HealMouse.connect("mouse_entered", can_click)
	$HealMouse.connect("mouse_exited", cant_click)


func can_click() -> void:
	hover = true
func cant_click() -> void:
	hover = false
