extends Control

@onready var master_volume_slider = $VBoxContainer/HSlider

func _ready():
	pass

func _on_h_slider_value_changed(value: float) -> void:
	AudioManager.set_bus_volume("Master", value)
