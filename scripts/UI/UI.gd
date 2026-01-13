extends CanvasLayer

@onready var portrait: TextureRect = $ControlPortrait/Portrait
@onready var control_buttons: Control = $ControlButtons

@onready var control_options: Control = $ControlOptions
@onready var text_ui: TextureRect = $ControlUI/TextUI
@onready var text: Control = $Text

@onready var book: Control = $Book

@onready var hands: Control = $Hands

@onready var character_1: Node3D = $"../Character1"

@onready var speak_texture: TextureButton = $ControlButtons/SpeakTexture

const CURSOR_HURT = preload("uid://uqjdfasne4es")

func _ready() -> void:
	Input.set_custom_mouse_cursor(CURSOR_HURT, Input.CURSOR_CROSS)
	
	portrait.visible = false
	text_ui.visible = false
	control_buttons.visible = false
	
	control_options.visible = false
	
	text.visible = false
	book.visible = false
	
	hands.visible = false

func _process(_delta: float) -> void:
	if book.visible == true:
		var texture_hover = load("res://placeholders/heart5.png")
		$ControlUI/BookButton.texture_normal = texture_hover
	else:
		var texture = load("res://placeholders/heart0.png")
		$ControlUI/BookButton.texture_normal = texture


func _on_bunker_show_options() -> void:
	portrait.visible = true
	text_ui.visible = true
	control_buttons.visible = true
	text.visible = true
	character_1.visible = false


func _on_book_button_pressed() -> void:
	if book.visible == false and hands.visible:
		book.visible = true
		hands.visible = false
	elif book.visible == false:
		book.visible = true
	elif book.visible == true:
		book.visible = false


func _on_return_button_pressed() -> void:
	if portrait.visible == true and text_ui.visible == true and control_buttons.visible == true and book.visible == false and hands.visible == false:
		portrait.visible = false
		text_ui.visible = false
		control_buttons.visible = false
		text.visible = false
		character_1.visible = true
	elif portrait.visible == true and control_buttons.visible == false and control_options.visible == true and book.visible == false and hands.visible == false:
		control_buttons.visible = true
		control_options.visible = false
	elif book.visible == true:
		book.visible = false
	elif hands.visible == true:
		hands.visible = false


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


func _on_hurt_button_pressed() -> void:
	hands.visible = true
