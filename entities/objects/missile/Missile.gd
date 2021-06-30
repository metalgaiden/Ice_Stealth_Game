extends Area2D
onready var switcher = get_node("/root/switcher")

var target
var steer_force = 50
var speed = 500
var velocity = Vector2()
var acceleration = Vector2()

func start(pos, dir, _target):
	position = pos
	rotation = dir
	target = _target
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	if ((target.position - position).length() > 10):
		acceleration += seek()
		velocity += acceleration * delta
		velocity = velocity.clamped(speed)
		rotation = velocity.angle()
	position += velocity * delta

func seek():
	var desired = (target.position - position).normalized() * speed
	var steer = (desired - velocity).normalized() * steer_force
	return steer

func _on_Missile_body_entered(body):
	if body.get_name() == 'Player':
		switcher.switch_scene("res://ui/game_over/Game over.tscn")
		queue_free()

func _on_Timer_timeout():
	queue_free()
