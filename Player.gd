extends KinematicBody2D

var velocity = Vector2()
var speed = 0
const turn_speed = 3
const acc = 3
const friction = .999

var points = []
var minPointDist = 50
var maxPoints = 15
var hole = []

func _ready():
	points = [position]

func _process(delta):
	get_input()
	move_and_slide(velocity * speed)
	trail()
	update()

func _draw():
	for point in points:
		draw_circle((point-position).rotated(-rotation), 5, Color(.867, .91, .247, 0.1))
	if hole.size() > 3:
		draw_colored_polygon(hole, Color(.867, .91, .247, 0.1))
		$hole/hole_shape.shape.set_point_cloud(hole)

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

func trail():
	if (position - points[0]).length() > minPointDist :
		points.push_front(position)
		if points.size() > maxPoints:
			points.pop_back()
	
	hole.clear()
	var i = 0
	
	for idx in points.size():
		var dist = (position - points[idx]).length()
		if  dist < 30 and idx > 0:
			i = idx
	while i > 0:
		hole.push_back((points[i]-position).rotated(-rotation))
		i -= 1
	if !hole.empty(): 
		points = [position]
