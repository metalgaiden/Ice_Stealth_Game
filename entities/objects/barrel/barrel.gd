extends KinematicBody2D


# determines if the barrel is icy
var i = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Area2D_area_entered(area):
	if area.name == "hole":
		$Sprite.self_modulate.r = 0
		i = true
