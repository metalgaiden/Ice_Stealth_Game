extends Control
onready var switcher = get_node("/root/switcher")

func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed('ui_accept'):
		switcher.return_to_last()

func _on_Button_pressed():
	switcher.return_to_last()

func _on_Button2_pressed():
	switcher.switch_scene("res://scenes/main/Main.tscn")
