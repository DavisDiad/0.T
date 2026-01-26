extends Node

var players := {}

var muted := false

func _ready() -> void:
	PollutionManager.connect("pollution_state_1", on_pollution)
	PollutionManager.connect("pollution_state_2", on_pollution)
	PollutionManager.connect("pollution_state_3", on_pollution)


func on_pollution():
	play("trumpets")
	play("breathing")

func register_player(id: String, player: AudioStreamPlayer):
	players[id] = player

func play(id: String):
	if muted:
		return
	
	if players.has(id):
		var p = players[id]
		
		if not p.playing:
			p.play()

func stop(id: String):
	if players.has(id):
		players[id].stop()

func toggle_mute():
	muted = !muted

	if muted:
		pause_all()
	else:
		resume_all()

func pause_all():
	for player in players.values():
		if is_instance_valid(player):
			player.stream_paused = true

func resume_all():
	for player in players.values():
		if is_instance_valid(player):
			player.stream_paused = false

func unregister_player(player):
	for key in players.keys():
		if players[key] == player:
			players.erase(key)
			return
