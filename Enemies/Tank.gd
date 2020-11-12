extends KinematicBody2D

export (PackedScene) var Missile
var target
var speed = 100
var velocity = Vector2()
var acceleration = Vector2()
var steer_force = 2
var l = false
var r = false

func start(_target = null):
	target = _target
	$Timer.start()

func _process(delta):
	if l == true && r == true:
		$Timer.stop()
		steer_force = 0
	$tank_turret.look_at(target.position)
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
	if r == true:
		pass
	elif area.name == 'b':
		if area.get_parent().i == true:
			$"Right wheel/Sprite".self_modulate.r = 0
			steer_force -= steer_force/2
			area.get_parent().queue_free()
			r = true

func _on_left_wheel_area_entered(area):
	if l == true:
		pass
	elif area.name == 'b':
		if area.get_parent().i == true:
			$"left wheel/Sprite".self_modulate.r = 0
			steer_force -= steer_force/2
			area.get_parent().queue_free()
			l = true

func shoot(pos):
	var m = Missile.instance()
	var a = (pos - global_position).angle()
	m.start(global_position, a, target)
	get_parent().add_child(m)

func _on_Timer_timeout():
	shoot(target.position)
	$Timer.start()
