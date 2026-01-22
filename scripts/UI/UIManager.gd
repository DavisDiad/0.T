extends CanvasLayer

signal show_character_on_bunker

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"..".connect("talking_to_npc", show_dialogue_UI)
	
	$UIButtons/ReturnTexture.connect("pressed", hide_UI)
	
	$UIButtons/BookButton.connect("pressed", show_book)
	
	$UIOptions/SpeakTexture/SpeakButton.connect("pressed", show_dialogue_options)
	
	$UIOptions/HurtTexture.connect("pressed", show_hurt_mini_game)
	
	$Portraits.visible = false
	$Text.visible = false
	$UIOptions.visible = false
	$DialogueOptions.visible = false
	$Book.visible = false
	$Hands.visible = false
	$HandsHurt.visible = false
	$HandsHeal.visible = false

func show_dialogue_UI() -> void:
	$Portraits.visible = true
	$Text.visible = true
	$UIOptions.visible = true


func hide_UI() -> void:
	if $Book.visible == true:
		$Book.visible = false
	
	
	elif $DialogueOptions.visible == true:
		$DialogueOptions.visible = false
		$UIOptions.visible = true	
	
	
	elif $Portraits.visible and $Text.visible and $UIOptions.visible:
		$Portraits.visible = false
		$Text.visible = false
		$UIOptions.visible = false
		
		emit_signal("show_character_on_bunker")


func show_book() -> void:
	if $Book.visible == false:
		$Book.visible = true
	else:
		$Book.visible = false


func show_dialogue_options() -> void:
	if $UIOptions.visible == true:
		$UIOptions.visible = false
		$DialogueOptions.visible = true


func show_hurt_mini_game() -> void:
	if $HandsHurt.visible == false:
		$HandsHurt.visible = true
