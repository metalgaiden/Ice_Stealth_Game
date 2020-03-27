extends KinematicBody2D

var target
var speed = 70
var velocity = Vector2()
var acceleration = Vector2()
var steer_force = 10
var l = false
var r = false

func start(_target = null):
	target = _target

func _process(delta):
	if l == true && r == true:
		print('boss killed')
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


func _on_Right_wheel_area_entered(area):
	if area.name == 'b':
		if area.get_parent().i == true:
			$"Right wheel/Sprite".self_modulate.r = 0
			area.get_parent().queue_free()
			r = true


func _on_left_wheel_area_entered(area):
	if area.name == 'b':
		if area.get_parent().i == true:
			$"left wheel/Sprite".self_modulate.r = 0
			area.get_parent().queue_free()
			l = true
