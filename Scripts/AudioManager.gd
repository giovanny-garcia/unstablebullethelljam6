extends Node

var buses = { # Dictionary of audio buses
	"Master": AudioServer.get_bus_index("Master"),
	"Music": AudioServer.get_bus_index("Music"),
	"SFX": AudioServer.get_bus_index("SFX"),
}

var sound_effects = { # Dictionary of sound effects
#	"jump": preload("res://Audio/SFX/boing.mp3"),
#	"coin": preload("res://Audio/SFX/coin.wav"),
#	"explosion": preload("res://Audio/SFX/explosion.wav"),
}

var music_player: AudioStreamPlayer = null
var sfx_player: Array[AudioStreamPlayer] = []

func _ready() -> void:
	# Initialize the music player
	music_player = AudioStreamPlayer.new()
	music_player.set_bus("Music")
	add_child(music_player)

	for i in range(5): # Initialize multiple SFX players
		var sfx = AudioStreamPlayer.new()
		sfx.set_bus("SFX")
		add_child(sfx)
		sfx_player.append(sfx)

func play_sfx(sound: String):
	if sound in sound_effects:
		for player in sfx_player:
			if not player.playing:
				player.stream = sound_effects[sound]
				player.play()
				return
			#if no free player, create a new one    
			var new_player = AudioStreamPlayer.new()
			new_player.set_bus("SFX")
			add_child(new_player)
			sfx_player.append(new_player)
			new_player.stream = sound_effects[sound]
			new_player.play()
#Play music by AudioStream or path
func play_music(stream: AudioStream):
	if music_player.stream != stream:
		music_player.stream = stream
		music_player.play()

func stop_music():
	if music_player.playing:
		music_player.stop()

#Adjust bus volume in decibels
func set_bus_volume(bus_name: String, volume: float):
	if bus_name in buses:
		var bus_index = buses[bus_name]
		if bus_index != -1:
			# Set the volume for the bus
			AudioServer.set_bus_volume_db(bus_index, volume)
		else:
			push_error("Bus not found: " + bus_name)
		

func set_bus_mute(bus_name: String, mute: bool):
	if bus_name in buses:
		AudioServer.set_bus_mute(buses[bus_name], mute)
