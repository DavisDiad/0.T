extends Node

var players := {}

func register_player(id: String, player: AudioStreamPlayer):
	players[id] = player

func play(id: String):
	if players.has(id):
		players[id].play()


func stop(id: String):
	if players.has(id):
		players[id].stop()
