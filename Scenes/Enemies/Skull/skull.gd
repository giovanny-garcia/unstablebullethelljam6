extends Area2D

#signal bullet_entered(bullet: Bullet)
@onready var healthBar = $HealthBar
@onready var bullet = $SkullBullet
var health = 4
var bulletSpeed: int = 200
var canShoot: bool = true

@onready var attackCooldownTimer = $Timer

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	healthBar.init_health(health)
	

func _set_health(value):
	health = health - value
	healthBar._set_health(health)
	if health <= 0:
		queue_free()
		return

func _on_area_entered(area):
	_set_health(1)
	print(health)

func _on_timer_timeout():
	canShoot = true

func _on_area_2d_body_entered(_body:Node2D):
	shoot()


func shoot():
	pass
