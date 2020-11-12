extends Area2D
onready var switcher = get_node("/root/switcher")

export (String) var level

func _ready():
	$Label.text = level

func _on_Level_transfer_area_entered(area):
	if area.get_name() == 'hole':
		switcher.switch_scene('Levels/' + level + '.tscn')
