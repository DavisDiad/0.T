extends CanvasLayer

@onready var portrait: TextureRect = $ControlPortrait/Portrait
@onready var control_buttons: Control = $ControlButtons
@onready var control_options: Control = $ControlOptions
@onready var text_ui: TextureRect = $ControlUI/TextUI
@onready var text: Control = $Text

@onready var character_1: Node3D = $"../Character1"

@onready var speak_texture: TextureButton = $ControlButtons/SpeakTexture


func _ready() -> void:
	portrait.visible = false
	text_ui.visible = false
	control_buttons.visible = false
	control_options.visible = false
	text.visible = false


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
	elif portrait.visible == true and control_buttons.visible == false and control_options.visible == true:
		control_buttons.visible = true
		control_options.visible = false


func _on_speak_button_pressed() -> void:
	var timer: Timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false
	timer.wait_time = 0.1
	timer.timeout.connect(_timer_Timeout)
	timer.start()

func _timer_Timeout():
	control_buttons.visible = false
	control_options.visible = true
