extends CanvasLayer

signal show_character_on_bunker


signal finished_displaying

var wound := 0


@onready var letter_display_timer: Timer = $Text/LetterDisplayTimer
var text = ""
var letter_index = 0
var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2


func _ready() -> void:
	$"..".connect("talking_to_npc", show_dialogue_UI)
	
	
	$UIButtons/ReturnTexture.connect("pressed", hide_UI)
	
	$UIButtons/BookButton.connect("pressed", show_book)
	
	$UIOptions/SpeakTexture/SpeakButton.connect("tween_finished", on_speak_pressed)
	
	$UIOptions/HurtTexture/HurtButton.connect("tween_finished", on_hurt_pressed)
	$Hands/HandsHurt.connect("aeiln_hurted", wounded_hand)
	
	$UIOptions/HealTexture/HealButton.connect("tween_finished", on_heal_pressed)
	
	
	DialogueManager.connect("dialogue_requested", on_dialogue_requested)
	
	
	letter_display_timer.connect("timeout", on_letter_display_timer_timeout)
	
	
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
	DialogueManager.show_dialogue("aeiln_initial_00")


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


func display_text(text_to_display: String) -> void:
	letter_display_timer.stop()

	text = text_to_display
	letter_index = 0

	$Text/DialoguePanel/RichTextLabel.text = ""

	display_letter()



func display_letter () -> void:
	if letter_index >= text.length():
		finished_displaying.emit()
		return
	
	match text [letter_index]:
		"!", ".", ",", "?":
			letter_display_timer.start(punctuation_time)
		" ":
			letter_display_timer.start(space_time)
		_:
			letter_display_timer.start(letter_time)
			
	$Text/DialoguePanel/RichTextLabel.text += text[letter_index]
	letter_index += 1

func on_letter_display_timer_timeout() -> void:
	display_letter()


func on_dialogue_requested(dialogue_text, options):
	print("dialogue requested")
	display_text(dialogue_text)
	
	if options == null:
		$DialogueOptions.visible = false
		$UIOptions.visible = true
	else:
		show_text_options(options)

func show_text_options(options):
	$DialogueOptions.visible = true
	
	
	$DialogueOptions/OptionATexture/OptionAButton.text = options["option1"]["text"]["en"]
	$DialogueOptions/OptionBTexture/OptionBButton.text = options["option2"]["text"]["en"]
	
	$DialogueOptions/OptionATexture/OptionAButton.pressed.connect(
		func(): DialogueManager.show_dialogue(options["option1"]["next"])
)

	$DialogueOptions/OptionBTexture/OptionBButton.pressed.connect(
		func(): DialogueManager.show_dialogue(options["option2"]["next"])
)
