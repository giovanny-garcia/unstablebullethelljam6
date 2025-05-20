extends Area2D

#signal bullet_entered(bullet: Bullet)
@onready var healthBar = $HealthBar
var health = 4

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	healthBar.init_health(health)

func _set_health(value):
	health = health - value
	healthBar._set_health(health)
	if health <= 0:
		queue_free()
		return
	
func _on_body_entered(body: Node) -> void:
	print("Detected body type: ", body)
	if body is Bullet:
		print("body is bullet")
	else:
		print("body is not bullet")
		

func _on_bullet_entered(_bullet):
	print("Bullet entered skull")
	queue_free()


func _on_area_entered(_area):
	_set_health(1)
