extends Control

@onready var music = preload("res://Audio/Menu/BulletHellMainMenuDemo.ogg")
@onready var packed_settings_scene

@export var music_level: float = -15.0
#@onready var packed_scene = preload("res://Scenes/Prototype/Prototype1.tscn")
#@onready var main_theme = preload("")


func _on_play_pressed():
	SceneManager.change_scene("Scenes/Levels/Cloverwood.tscn")
	AudioManager.play_sfx("button")

func _on_options_pressed():
	AudioManager.play_sfx("button")
	 # Replace with function body.

func _on_quit_pressed():
	AudioManager.play_sfx("button")
	#audio play sfxa
	get_tree().quit()

func _ready() -> void:
	AudioManager.play_music(music, music_level)
	
