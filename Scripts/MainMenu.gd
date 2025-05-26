extends Control

@onready var music = preload("res://Audio/Menu/BulletHellMainMenuDemo.ogg")

@export var music_level: float = -15.0
#@onready var packed_scene = preload("res://Scenes/Prototype/Prototype1.tscn")
#@onready var main_theme = preload("")


func _on_play_pressed():
	SceneManager.change_scene("Scenes/Levels/Cloverwood.tscn")
	#audio

func _on_options_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	#audio play sfx
	get_tree().quit()

func _ready() -> void:
	AudioManager.play_music(music, music_level)
	
