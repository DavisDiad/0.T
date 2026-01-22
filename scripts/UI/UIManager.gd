extends CanvasLayer

signal show_character_on_bunker


var wound := 0


func _ready() -> void:
	$"..".connect("talking_to_npc", show_dialogue_UI)
	
	
	$UIButtons/ReturnTexture.connect("pressed", hide_UI)
	
	$UIButtons/BookButton.connect("pressed", show_book)
	
	$UIOptions/SpeakTexture/SpeakButton.connect("tween_finished", on_speak_pressed)
	
	
	$UIOptions/HurtTexture/HurtButton.connect("tween_finished", on_hurt_pressed)
	$Hands/HandsHurt.connect("aeiln_hurted", wounded_hand)
	
	
	$UIOptions/HealTexture/HealButton.connect("tween_finished", on_heal_pressed)
	
	
	
	$Portraits.visible = false
	$Text.visible = false
	$UIOptions.visible = false
	$DialogueOptions.visible = false
	$Book.visible = false
	$Hands.visible = false
	$Hands/HandsHurt.visible = false
	$Hands/HandsHeal.visible = false

func show_dialogue_UI() -> void:
	$Portraits.visible = true
	$Text.visible = true
	$UIOptions.visible = true


func hide_UI() -> void:
	if $Book.visible == true:
		$Book.visible = false
	
	elif $Hands.visible == true:
		$Hands.visible = false
		$Hands/HandsHurt.visible = false
		$Hands/HandsHeal.visible = false
	
	
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


func on_speak_pressed() -> void:
	show_dialogue_options()
func show_dialogue_options() -> void:
		$UIOptions.visible = false
		$DialogueOptions.visible = true


func on_hurt_pressed() -> void:
	show_hands_hurt()
func show_hands_hurt() -> void:
	$Hands.visible = true
	$Hands/HandsHurt.visible = true
func wounded_hand() -> void:
	if wound != 2:
		wound +=1
		print(wound)
	if wound == 1:
		$Hands/HandsTexture.texture = load("res://placeholders/Aeil_wound1.png")
	elif wound == 2:
		$Hands/HandsTexture.texture = load("res://placeholders/Aeil_wound2.png")


func on_heal_pressed() -> void:
	show_hands_heal()
func show_hands_heal() -> void:
	$Hands.visible = true
	$Hands/HandsHeal.visible = true
