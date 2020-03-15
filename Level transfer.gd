extends Area2D

export (String) var level

func _ready():
	$Label.text = level

func _on_Level_transfer_area_entered(area):
	if area.get_name() == 'hole':
		get_tree().change_scene('Levels/' + level + '.tscn')
