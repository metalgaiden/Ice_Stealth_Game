extends Area2D
onready var switcher = get_node("/root/switcher")

export (PackedScene) var level

func _ready():
	$Label.text = self.name

func _on_Level_transfer_area_entered(area):
	if area.get_name() == 'hole':
		switcher.switch_scene(level.resource_path)
