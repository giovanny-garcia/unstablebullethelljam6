extends Node2D


@onready var spawnpoint = $SpawnPoint
@onready var player = $Player

func _ready():
	player.position = spawnpoint.position
	# :) 
