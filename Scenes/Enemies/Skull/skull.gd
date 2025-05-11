extends Area2D

signal bullet_entered(bullet: Node)

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	
func _on_body_entered(body: Node) -> void:
	print("Detected body type: ", body)
	if body is Bullet:
		print("body is bullet")
	else:
		print("body is not bullet")
		

func _on_bullet_entered(bullet):
	print("Bullet entered skull")
	queue_free()


func _on_area_entered(area):
	if area is Bullet:
		print("Area entered bullet")
		queue_free()
	else:
		print("Area entered not bullet")
		queue_free() #for now this works but is far from optimal. 
