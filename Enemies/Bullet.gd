extends Area2D
onready var switcher = get_node("/root/switcher")

var speed = 1000
var velocity = Vector2()

func start(pos, dir):
	position = pos
	rotation = dir
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	position += velocity * delta

func _on_Bullet_body_entered(body):
	if body.get_name() == 'Player':
		switcher.switch_scene("Game over.tscn")
	queue_free()
	
