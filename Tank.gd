extends KinematicBody2D

var target
var speed = 70
var velocity = Vector2()
var acceleration = Vector2()
var steer_force = 10

func start(_target = null):
	target = _target

func _process(delta):
	if ((target.position - position).length() > 300):
		acceleration += seek()
		velocity += acceleration * delta
		velocity = velocity.clamped(speed)
		rotation = velocity.angle()
	else:
		pass
	position += velocity * delta

func seek():
    var desired = (target.position - position).normalized() * speed
    var steer = (desired - velocity).normalized() * steer_force
    return steer