extends CanvasLayer

@onready var portrait: TextureRect = $ControlPortrait/Portrait
@onready var control_buttons: Control = $ControlButtons
@onready var text_ui: TextureRect = $ControlUI/TextUI
@onready var text: Control = $Text

@onready var character_1: Node3D = $"../Character1"


func _on_bunker_show_options() -> void:
	portrait.visible = true
	text_ui.visible = true
	control_buttons.visible = true
	text.visible = true
	character_1.visible = false


func _on_return_button_pressed() -> void:
	if portrait.visible == true and text_ui.visible == true and control_buttons.visible == true:
		portrait.visible = false
		text_ui.visible = false
		control_buttons.visible = false
		text.visible = false
		character_1.visible = true
