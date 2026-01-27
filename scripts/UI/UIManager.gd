extends CanvasLayer



signal show_character_on_bunker

signal finished_displaying

var wound := 0

@onready var voice_player: AudioStreamPlayer = $UISounds/VoicePlayer
@onready var speech_sound = preload("res://sprites/sounds/716382__sadiquecat__metal-paper-click-1.wav")



@onready var letter_display_timer: Timer = $Text/LetterDisplayTimer
var text = ""
var letter_index = 0
var letter_time = 0.02
var space_time = 0.06
var punctuation_time = 0.2


var before_healed_dialogue = false
var before_hurt_dialogue = false

var current_options = null

var healed = false
var hurted = false
var fully_hurted = false
var fully_hurted_state1 = false
var fully_hurted_state2 = false

var pollution_state = 0

var killing = false

var cross_cursor := preload("res://placeholders/cursor_hurt.png")

func _ready() -> void:
	Input.set_custom_mouse_cursor(
		cross_cursor,
		Input.CURSOR_CROSS
	)
	
	$"..".connect("talking_to_npc", show_dialogue_UI)
	
	
	$UIButtons/ReturnTexture.connect("pressed", hide_UI)
	
	$UIButtons/BookButton.connect("pressed", show_book)
	
	$UIButtons/MenuButton.connect("pressed", show_menu)
	
	
	$UIOptions/SpeakTexture/SpeakButton.connect("tween_finished", on_speak_pressed)
	
	$UIOptions/HurtTexture/HurtButton.connect("tween_finished", on_hurt_pressed)
	$Hands/HandsHurt.connect("aeiln_hurted", wounded_hand)
	
	$UIOptions/HealTexture/HealButton.connect("tween_finished", on_heal_pressed)
	
	$UIOptions/KillTexture/KillButton.connect("tween_finished", on_kill_pressed)
	
	$DialogueOptions/OptionATexture/OptionAButton.connect("tween_finished", on_optionA_pressed)
	$DialogueOptions/OptionBTexture/OptionBButton.connect("tween_finished", on_optionB_pressed)
	
	
	$Hands/HandsHeal.connect("heal_completed", on_heal_completed)
	
	$Hands/HandsHurt.connect("visibility_changed", hurted_dialogue)
	
	$Hands/HandsHeal.connect("visibility_changed", healed_dialogue)
	
	$"../Character1".connect("visibility_changed", inicial_dialogue)
	
	DialogueManager.connect("dialogue_requested", on_dialogue_requested)
	
	PollutionManager.connect("pollution_state_1", on_pollution_state_1)
	PollutionManager.connect("pollution_state_2", on_pollution_state_2)
	PollutionManager.connect("pollution_state_3", on_pollution_state_3)
	
	letter_display_timer.connect("timeout", on_letter_display_timer_timeout)
	
	
	$Portraits.visible = false
	$Text.visible = false
	$UIOptions.visible = false
	$DialogueOptions.visible = false
	$Book.visible = false
	$Hands.visible = false
	$Hands/HandsHurt.visible = false
	$Hands/HandsHeal.visible = false
	$RCT.visible = true
	$Menu.visible = false

func show_dialogue_UI() -> void:
	$Portraits.visible = true
	$Text.visible = true
	$UIOptions.visible = true


func inicial_dialogue():
	$Text/DialoguePanel/RichTextLabel.text = "..."


func hide_UI() -> void:
	if $Menu.visible == true:
		$Menu.visible = false
	
	elif $Book.visible == true:
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

func show_menu():
	if $Menu.visible == false:
		$Menu.visible = true
	else:
		$Menu.visible = false

func on_speak_pressed() -> void:
	PollutionManager.apply_action("speak")
	
	show_dialogue_options()
	
	if wound == 0:
		DialogueManager.show_dialogue("aeiln_initial_00", speech_sound)
	
	elif pollution_state == 1:
		DialogueManager.show_dialogue("aeiln_state1_00", speech_sound)
	elif pollution_state == 2:
		DialogueManager.show_dialogue("aeiln_state2_00", speech_sound)
	elif pollution_state == 3:
		DialogueManager.show_dialogue("aeiln_state100_00", speech_sound)
	
	elif wound != 0:
		wounded_dialogue()
	
	else:
		DialogueManager.show_dialogue("aeiln_initial_00", speech_sound)

func wounded_dialogue():
	if wound == 1:
		DialogueManager.show_dialogue("aeiln_hurted_00", speech_sound)
	if wound == 2:
		DialogueManager.show_dialogue("aeiln_fully_hurted_00", speech_sound)
	
	if wound == 2 and pollution_state == 1:
		DialogueManager.show_dialogue("aeiln_fully_hurted_state1_00", speech_sound)
	if wound == 2 and pollution_state >= 2:
		DialogueManager.show_dialogue("aeiln_fully_hurted_state2_00", speech_sound)

func show_dialogue_options() -> void:
		$UIOptions.visible = false
		$DialogueOptions.visible = true


func on_hurt_pressed() -> void:
	PollutionManager.apply_action("hurt")
	
	if before_hurt_dialogue == false:
		DialogueManager.show_dialogue("aeiln_before_hurted_00", speech_sound)
		before_hurt_dialogue = true
		return
	else:
		show_hands_hurt()

func show_hands_hurt() -> void:
	$Hands.visible = true
	$Hands/HandsHurt.visible = true

func wounded_hand() -> void:
	PollutionManager.apply_action("hurt")
	
	if wound != 2:
		wound +=1
	
	if wound == 1:
		$Hands/HandsTexture.texture = load("res://placeholders/Aeil_wound1.png")
	if wound == 2:
		$Hands/HandsTexture.texture = load("res://placeholders/Aeil_wound2.png")
	
	if wound == 2 and pollution_state == 1:
		$Hands/HandsTexture.texture = load("res://placeholders/Aeil_wound2_state2.png")
	if wound == 2 and pollution_state >= 2:
		$Hands/HandsTexture.texture = load("res://placeholders/Aeil_wound2_state3.png")

func hurted_dialogue():
	if wound == 1 and hurted == false and $Hands/HandsHurt.visible == false :
		DialogueManager.show_dialogue("aeiln_hurted_00", speech_sound)
		hurted = true
	if wound == 2 and fully_hurted == false and $Hands/HandsHurt.visible == false:
		DialogueManager.show_dialogue("aeiln_fully_hurted_00", speech_sound)
		fully_hurted = true
	
	if wound == 2 and pollution_state == 1 and fully_hurted_state1 == false and $Hands/HandsHurt.visible == false:
		DialogueManager.show_dialogue("aeiln_fully_hurted_state1_00", speech_sound)
		fully_hurted_state1 = true
	if wound == 2 and pollution_state >= 2 and fully_hurted_state2 == false and $Hands/HandsHurt.visible == false:
		DialogueManager.show_dialogue("aeiln_fully_hurted_state2_00", speech_sound)
		fully_hurted_state2 = true

func on_heal_pressed() -> void:
	PollutionManager.apply_action("heal")
	if before_healed_dialogue == false:
		DialogueManager.show_dialogue("aeiln_before_healed_00", speech_sound)
		before_healed_dialogue = true
		return
	else:
		show_hands_heal()
		
func show_hands_heal() -> void:
	$Hands.visible = true
	$Hands/HandsHeal.visible = true

func on_heal_completed() -> void:
	healed = true

func healed_dialogue():
	if healed == true and $Hands/HandsHeal.visible == false:
		if wound != 0:
			DialogueManager.show_dialogue("aeiln_healed_hurted_00", speech_sound)
			PollutionManager.apply_action("healed")
			healed = false
		else:
			DialogueManager.show_dialogue("aeiln_healed_00", speech_sound)
			PollutionManager.apply_action("healed")
			healed = false
	else:
		return

func display_text(text_to_display: String, speech_sfx: AudioStream) -> void:
	letter_display_timer.stop()

	text = text_to_display
	letter_index = 0
	
	voice_player.stream = speech_sfx

	$Text/DialoguePanel/RichTextLabel.text = ""

	display_letter()



func display_letter () -> void:
	if letter_index >= text.length():
		finished_displaying.emit()
		return
	
	var char = text[letter_index]
	
	match text [letter_index]:
		"!", ".", ",", "?":
			letter_display_timer.start(punctuation_time)
		" ":
			letter_display_timer.start(space_time)
		_:
			letter_display_timer.start(letter_time)
			if SoundsManager.muted == false:
				voice_player.play_letter(char)
			
	$Text/DialoguePanel/RichTextLabel.text += char
	letter_index += 1

func on_letter_display_timer_timeout() -> void:
	
	display_letter()


func on_dialogue_requested(dialogue_text, options, speech_sfx):
	display_text(dialogue_text, speech_sfx)
	
	current_options = options
	
	if options == null:
		$DialogueOptions.visible = false
		$UIOptions.visible = true
	else:
		show_text_options()

func show_text_options():
	if current_options == null:
		return

	$DialogueOptions.visible = true

	$DialogueOptions/OptionATexture/OptionAButton.text = current_options["option1"]["text"]

	$DialogueOptions/OptionBTexture/OptionBButton.text = current_options["option2"]["text"]
func on_optionA_pressed():
	if pollution_state == 3:
		DialogueManager.show_dialogue(
			current_options["option1"]["next"]
			, speech_sound
		)
		$DialogueOptions.visible = false
		$UIOptions.visible = false
		
		await get_tree().create_timer(5.0).timeout
		
		Transition.transition()
		await Transition.on_transition_finished
		get_tree().change_scene_to_file("res://scenes/final_cutscene.tscn")
	
	elif current_options == null:
		return
	
	else:
		DialogueManager.show_dialogue(
			current_options["option1"]["next"]
			, speech_sound
		)
		PollutionManager.apply_action("option")
func on_optionB_pressed():
	if pollution_state == 3:
		DialogueManager.show_dialogue(
		current_options["option2"]["next"]
		, speech_sound
	)
		$DialogueOptions.visible = false
		$UIOptions.visible = false
		
		await get_tree().create_timer(5.0).timeout
		
		Transition.transition()
		await Transition.on_transition_finished
		get_tree().change_scene_to_file("res://scenes/final_cutscene.tscn")
	
	elif current_options == null:
		return
	
	else:
		DialogueManager.show_dialogue(
			current_options["option2"]["next"]
			, speech_sound
		)
		PollutionManager.apply_action("option")

func on_kill_pressed():
	if killing == false:
		DialogueManager.show_dialogue("aeiln_kill_00", speech_sound)
		killing = true
	else:
		$Portraits/HurtMouse.visible = true
		$Portraits/AeilHurt.visible = true
		
		$Portraits/AeilHurt.play()
		SoundsManager.play("scream")
		await get_tree().create_timer(1.5).timeout
		$Portraits/AeilHurt.stop()
		$Portraits/AeilHurt.visible = false
		
		Transition.transition()
		await Transition.on_transition_finished
		get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")


func on_pollution_state_1():
	pollution_state = 1
func on_pollution_state_2():
	pollution_state = 2
func on_pollution_state_3():
	pollution_state = 3
	DialogueManager.show_dialogue("aeiln_state100_00", speech_sound)
