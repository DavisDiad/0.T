extends AudioStreamPlayer

@export var audio_id := ""

func _ready():
	SoundsManager.register_player(audio_id, self)
