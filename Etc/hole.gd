extends Area2D
onready var switcher = get_node("/root/switcher")

var r

func start(pos, radius):
	position = pos
	r = radius

func _draw():
	draw_circle(position, 10, Color(1.0, .329, .298))

func _on_hole_body_entered(body):
	if body.get_name() == 'Player':
		switcher.switch_scene("Game over.tscn")
