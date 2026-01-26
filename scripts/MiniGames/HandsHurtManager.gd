extends Control

signal aeiln_hurted


var hover = false
var just_pressed = false

func _ready() -> void:
	$HurtMouse.connect("mouse_entered", can_click)
	$HurtMouse.connect("mouse_exited", cant_click)
	
	$".".connect("visibility_changed", can_click_again)


func can_click() -> void:
	hover = true
func cant_click() -> void:
	hover = false
func can_click_again() -> void:
	just_pressed = false
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click") and hover and not $HurtAnimation.is_playing() and just_pressed == false:
		SoundsManager.play("scream")
		
		$HurtAnimation.visible = true
		$HurtAnimation.play()
		await get_tree().create_timer(1.0).timeout
		$HurtAnimation.stop()
		$HurtAnimation.visible = false
		emit_signal("aeiln_hurted")
		just_pressed = true
