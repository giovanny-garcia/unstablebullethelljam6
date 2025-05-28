extends Node2D


@onready var spawnpoint = $SpawnPoint
@onready var player = $Player

var dialogue_resource = preload("res://Dialogue/CloverWood.dialogue")

func _ready():
	player.position = spawnpoint.position
	# :) 
	DialogueManager.show_dialogue_balloon(dialogue_resource)	
