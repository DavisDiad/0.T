extends Node

var hands = preload("res://placeholders/Aeil_hands.png")
var hands_wound1 = preload("res://placeholders/Aeil_wound1.png")
var hands_wound2 = preload("res://placeholders/Aeil_wound2.0.png")
var hands_wound2_state2 = preload("res://placeholders/Aeil_wound2_state2.png")
var hands_wound2_state3 = preload("res://placeholders/Aeil_wound2_state3.png")

@onready var hands_texture: TextureRect = $"."

@onready var area_2d: Area2D = $"../../Area2D"

@onready var hurt_animation: AnimatedSprite2D = $"../HurtAnimation"

var hovering = false

func _ready() -> void:
	hands_texture.texture = hands
	hurt_animation.visible = false

func _process(_delta: float) -> void:
	if hovering == true and Input.is_action_just_pressed("left_click"):
		hurt_animation.visible = true
		hurt_animation.play()
		var timer: Timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
		timer.wait_time = 1
		timer.timeout.connect(_timer_Timeout)
		timer.start()

func _timer_Timeout():
	hurt_animation.stop()
	hurt_animation.visible = false
	hands_texture.texture = hands_wound1

func _on_mouse_mouse_entered() -> void:
	hovering = true

func _on_mouse_mouse_exited() -> void:
	hovering = false
