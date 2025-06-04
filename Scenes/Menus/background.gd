extends Sprite2D

@export var rotation_speed: float = 0.005

func _process(delta):
	rotation += rotation_speed * delta
