extends Control

#@onready var packed_scene = preload("res://Scenes/Prototype/Prototype1.tscn")
#@onready var main_theme = preload("")

func _on_play_pressed():
	SceneManager.change_scene("Scenes/Prototype/Prototype1.tscn")
	#audio

func _on_options_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	#audio play sfx
	get_tree().quit()
