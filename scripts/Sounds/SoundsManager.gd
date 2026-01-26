extends Node

var players := {}

func _ready() -> void:
	PollutionManager.connect("pollution_state_1", on_pollution)
	PollutionManager.connect("pollution_state_2", on_pollution)
	PollutionManager.connect("pollution_state_2", on_pollution)


func on_pollution():
	play("trumpets")
	play("breathing")

func register_player(id: String, player: AudioStreamPlayer):
	players[id] = player

func play(id: String):
	if players.has(id):
		var p = players[id]
		
		if not p.playing:
			p.play()

func stop(id: String):
	if players.has(id):
		players[id].stop()
