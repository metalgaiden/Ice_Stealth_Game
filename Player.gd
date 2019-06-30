extends KinematicBody2D

var velocity = Vector2()
var speed = 0

const turn_speed = 3
const acc = 3
const friction = .999

func get_input():
	if Input.is_action_pressed('right'):
		rotation_degrees += turn_speed
		speed *= pow(friction, 3)
		if Input.is_action_pressed('down'):
			rotation_degrees += turn_speed * 1.3
			speed *= pow(friction, 3)
	if Input.is_action_pressed('left'):
		rotation_degrees -= turn_speed
		speed *= pow(friction, 3)
		if Input.is_action_pressed('down'):
			rotation_degrees -= turn_speed * 1.3
			speed *= pow(friction, 3)
	
	velocity = Vector2(1,0).rotated(rotation)
	
	if Input.is_action_pressed("up"):
		if get_slide_count() > 0:
			speed *= pow(friction, 10)
		else:
			speed += acc
	speed *= pow(friction, 2)

func _physics_process(delta):
	get_input()
	move_and_slide(velocity * speed)