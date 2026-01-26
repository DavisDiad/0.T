extends AudioStreamPlayer

@export var base_pitch := 1.0
@export var vowel_boost := 0.10
@export var random_range := 0.1

func play_letter(letter: String):

	if stream == null:
		return

	pitch_scale = base_pitch + randf_range(-random_range, random_range)

	if letter.to_lower() in ["a","e","i","o","u"]:
		pitch_scale += vowel_boost

	play()
