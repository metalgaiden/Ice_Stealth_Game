extends KinematicBody2D

export (float) var fire_rate
export (PackedScene) var Bullet
export (PackedScene) var hole
var laser_color = Color(1.0, .329, .298)

var target
var hit_pos = Vector2(0,0)
var can_shoot = false
var seen = false
var hole_shape

func _ready():
	$ShootTimer.wait_time = fire_rate
	$Sprite.self_modulate.r = 0.5

func _physics_process(delta):
	update()
	if target:
		aim()

func aim():
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(position, target.position,
[self], collision_mask)
	if result:
		hit_pos = result.position
		if result.collider.name == 'Player':
			rotation = (target.position - position).angle()
			if seen == false:
				$ShootTimer.start()
				$Sprite.self_modulate.r = 1
				seen = true
			elif can_shoot:
				shoot(target.position)

func shoot(pos):
	var b = Bullet.instance()
	var a = (pos - global_position).angle()
	b.start(global_position, a + rand_range(-0.05, 0.05))
	get_parent().add_child(b)
	can_shoot = false
	$ShootTimer.start()

func _draw():
	if target:
		draw_line(Vector2(), (hit_pos - position).rotated(-rotation), laser_color)
		draw_circle((hit_pos - position).rotated(-rotation), 5, laser_color)

func _on_Visibility_body_entered(body):
	if target:
		return
	target = body

func _on_Visibility_body_exited(body):
	if body == target:
		target = null
		$ShootTimer.stop()
		can_shoot = false
		seen = false
		$Sprite.self_modulate.r = 0.5

func _on_ShootTimer_timeout():
	can_shoot = true

func _on_hurtbox_area_entered(area):
	if area.get_name() == 'hole':
		var arr = area.get_children()
		hole_shape = arr[0].shape.points
		call_deferred('make_hole')
		queue_free()

func make_hole():
	var a = hole.instance()
	var radius
	if target:
		radius = target.get_global_position().distance_to(self.get_global_position())
	else:
		radius = 1
	a.start(global_position, radius)
	get_parent().add_child(a)

