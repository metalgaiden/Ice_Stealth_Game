extends Area2D

func start(pos, dir):
	position = pos
	rotation = dir

func _on_hole_body_entered(body):
	if body.get_name() == 'Player':
		get_tree().change_scene("Game over.tscn")
