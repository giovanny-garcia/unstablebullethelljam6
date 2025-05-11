extends Node

@export var max_health: int = 100
var current_health: int

signal health_changed(current: int, max: int)
signal died()

func _ready():
    current_health = max_health
    
func apply_damage(amount: int) -> void:
    current_health -= amount
    current_health = clamp(current_health, 0, max_health)
    emit_signal("health_changed", current_health, max_health)

    if current_health == 0:
        emit_signal("died")

func heal(amount: int) -> void:
    current_health += amount
    current_health = clamp(current_health, 0, max_health)
    emit_signal("health_changed", current_health, max_health)

func reset_health() -> void:
    current_health = max_health
    emit_signal("health_changed", current_health, max_health)