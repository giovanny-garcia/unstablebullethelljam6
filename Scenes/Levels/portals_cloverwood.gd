extends Node2D

@onready var library_entrance = $Library/LibraryEntrance
@onready var library_exit = $Library/LibraryExit
@onready var forest_entrance = $Forest/ForestEntrance
@onready var forest_exit = $Forest/ForestExit

func _on_library_exit_body_entered(_body:Node2D):
	PortalManager.teleport_player_to(library_entrance.global_position, "Cloverwood")

func _on_library_portal_body_entered(_body:Node2D):
	PortalManager.teleport_player_to(library_exit.global_position, "Cloverwood")

func _on_forest_exit_body_exited(_body:Node2D):
	PortalManager.teleport_player_to(forest_entrance.global_position, "Cloverwood")

func _on_forest_entrance_body_entered(_body:Node2D):
	PortalManager.teleport_player_to(forest_exit.global_position, "Cloverwood")
