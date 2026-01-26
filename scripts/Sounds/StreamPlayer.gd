extends AudioStreamPlayer

@export var audio_id := ""

func _ready():
	SoundsManager.register_player(audio_id, self)
	tree_exited.connect(_on_removed)

func _on_removed():
	SoundsManager.unregister_player(self)
