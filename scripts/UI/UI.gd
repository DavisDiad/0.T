extends CanvasLayer
#
#@onready var portrait: TextureRect = $ControlPortrait/Portrait
#@onready var control_buttons: Control = $ControlButtons
#
#@onready var control_options: Control = $ControlOptions
#@onready var text_ui: TextureRect = $ControlUI/TextUI
#@onready var text: Control = $Text
#@onready var rich_text_label: RichTextLabel = $Text/Dialogue_Panel/RichTextLabel
#
#
#@onready var book: Control = $Book
#
#@onready var hands: Control = $Hands
#
#@onready var character_1: Node3D = $"../Character1"
#
#@onready var speak_texture: TextureButton = $ControlButtons/SpeakTexture
#
#const CURSOR_HURT = preload("uid://uqjdfasne4es")
#
#@onready var hover: AudioStreamPlayer = $UISounds/Hover
#@onready var click: AudioStreamPlayer = $UISounds/Click
#
#@onready var heal: Control = $Heal
#var heal_hover = false
#var completed = false
#var fill_time := 2.0
#var hold_time := 0.0
#var is_hovered := false
#var start_color := Color.WHITE
#var target_color := Color.LIGHT_GREEN
#
#func _ready() -> void:
	#Input.set_custom_mouse_cursor(CURSOR_HURT, Input.CURSOR_CROSS)
	#
	#portrait.visible = false
	#text_ui.visible = false
	#control_buttons.visible = false
	#
	#control_options.visible = false
	#
	#text.visible = false
	#rich_text_label.visible = false
	#book.visible = false
	#
	#hands.visible = false
	#
	#heal.visible = false
	#heal_hover = false
	#start_color.a8 = 0
	#
	##$Heal/TextureRect.modulate = Color.BLUE
#
#func _process(delta: float) -> void:
	#if book.visible == true:
		#var texture_hover = load("res://placeholders/heart5.png")
		#$ControlUI/BookButton.texture_normal = texture_hover
	#else:
		#var texture = load("res://placeholders/heart0.png")
		#$ControlUI/BookButton.texture_normal = texture
	#
	#if heal_hover == true and Input.is_action_just_pressed("left_click"):
		#$UISounds/Healing.play()
	#elif heal_hover == false and Input.is_action_just_released("left_click"):
		#$UISounds/Healing.stop()
	#if heal_hover == true and Input.is_action_pressed("left_click"):
		#hold_time += delta
	#else:
		#hold_time -= delta
		#$UISounds/Healing.stop()
	#hold_time = clamp(hold_time, 0.0, fill_time)
	#var t := hold_time / fill_time
	#$Heal/TextureRect.modulate = start_color.lerp(target_color, t)
	#if hold_time >= fill_time:
		#completed = true
	#
	#if completed == true:
		#$Heal.visible = false
		#$UISounds/Healed.play()
		#
		#$Hands/HurtAnimation.visible = true
		#$Hands/HurtAnimation.play("heal")
		#var timer: Timer = Timer.new()
		#add_child(timer)
		#timer.one_shot = true
		#timer.autostart = false
		#timer.wait_time = 1
		#timer.timeout.connect(_timer_Timeout)
		#timer.start()
		#
		#completed = false
#
#func _on_bunker_show_options() -> void:
	#portrait.visible = true
	#text_ui.visible = true
	#control_buttons.visible = true
	#control_options.visible = false
	#text.visible = true
	#character_1.visible = false
	#rich_text_label.visible = true
#
#
#func _on_book_button_pressed() -> void:
	#click.play()
	#if book.visible == false and heal.visible == true:
		#book.visible = true
		#heal.visible = false
		#hands.visible = false
	#elif book.visible == false and hands.visible == true:
		#book.visible = true
		#hands.visible = false
	#elif book.visible == false:
		#book.visible = true
	#elif book.visible == true:
		#book.visible = false
#
#
#func _on_return_button_pressed() -> void:
	#click.play()
	#if portrait.visible == true and text_ui.visible == true and control_buttons.visible == true and book.visible == false and hands.visible == false:
		#portrait.visible = false
		#text_ui.visible = false
		#control_buttons.visible = false
		#text.visible = false
		#character_1.visible = true
	#elif portrait.visible == true and control_buttons.visible == false and control_options.visible == true and book.visible == false and hands.visible == false:
		#control_buttons.visible = true
		#control_options.visible = false
	#elif book.visible == true:
		#book.visible = false
	#elif hands.visible == true and heal.visible:
		#hands.visible = false
		#heal.visible = false
	#elif hands.visible == true:
		#hands.visible = false
#
#
#func _on_speak_button_pressed() -> void:
	#click.play()
	#var timer: Timer = Timer.new()
	#add_child(timer)
	#timer.one_shot = true
	#timer.autostart = false
	#timer.wait_time = 0.1
	#timer.timeout.connect(_timer_Timeout)
	#timer.start()
#
#func _timer_Timeout():
	#if $Hands/HurtAnimation.visible == true:
		#$Hands/HurtAnimation.stop()
		#$Hands/HurtAnimation.visible = false
	#else:
		#control_buttons.visible = false
		#control_options.visible = true
#
#
#func _on_hurt_button_pressed() -> void:
	#click.play()
	#hands.visible = true
	#$Hands/Mouse.visible = true
#
#func _on_heal_button_pressed() -> void:
	#click.play()
	#hands.visible = true
	#$Hands/Mouse.visible = false
	#$Heal.visible = true
#
#func _on_heal_mouse_mouse_entered() -> void:
	#hover.play()
	#heal_hover = true
#
#func _on_heal_mouse_mouse_exited() -> void:
	#heal_hover = false
#
#func _on_book_button_mouse_entered() -> void:
	#hover.play()
#
#func _on_speak_button_mouse_entered() -> void:
	#hover.play()
#
#func _on_hurt_button_mouse_entered() -> void:
	#hover.play()
#
#func _on_heal_button_mouse_entered() -> void:
	#hover.play()
#
#func _on_option_a_button_pressed() -> void:
	#click.play()
	#var timer: Timer = Timer.new()
	#add_child(timer)
	#timer.one_shot = true
	#timer.autostart = false
	#timer.wait_time = 0.1
	#timer.timeout.connect(_timer_Timeout2)
	#timer.start()
#
#func _on_option_a_button_mouse_entered() -> void:
	#hover.play()
#
#func _on_option_b_button_pressed() -> void:
	#click.play()
	#var timer: Timer = Timer.new()
	#add_child(timer)
	#timer.one_shot = true
	#timer.autostart = false
	#timer.wait_time = 0.1
	#timer.timeout.connect(_timer_Timeout2)
	#timer.start()
#
#func _on_option_b_button_mouse_entered() -> void:
	#hover.play()
#
#func _timer_Timeout2():
	#control_options.visible = false
	#control_buttons.visible = true
