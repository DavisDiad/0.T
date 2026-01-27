extends Control

signal heal_completed

var hover = false

var completed = false
var fill_time := 2.0
var hold_time := 0.0
var start_color := Color.WHITE
var target_color := Color.LIGHT_GREEN

func _ready() -> void:
	$HealMouse.connect("mouse_entered", can_click)
	$HealMouse.connect("mouse_exited", cant_click)
	
	start_color.a8 = 0


func can_click() -> void:
	hover = true
func cant_click() -> void:
	hover = false
func _process(delta: float) -> void:
	if Input.is_action_pressed("left_click") and hover and $HealedHand.visible:
		hold_time += delta
	else:
		hold_time -= delta
	
	if Input.is_action_just_pressed("left_click") and hover and $HealedHand.visible:
		SoundsManager.play("healing")
	if Input.is_action_just_released("left_click"):
		SoundsManager.stop("healing")


	hold_time = clamp(hold_time, 0.0, fill_time)
	var t := hold_time / fill_time
	$HealedHand.modulate = start_color.lerp(target_color, t)
	
	
	if hold_time >= fill_time:
		SoundsManager.stop("healing")
		SoundsManager.play("healed")
		hover = false
		
		healed()


func healed() -> void:
	$HealAnimation.visible = true
	$HealAnimation.play()
	await get_tree().create_timer(1.0).timeout
	$HealAnimation.stop()
	hover = false
	completed = false
	$HealAnimation.visible = false
	$HealedHand.visible = false
	
	heal_completed.emit()
