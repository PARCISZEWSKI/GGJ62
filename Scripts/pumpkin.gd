extends Node2D

var animation_list = ["default", "new_animation", "new_animation_1"]
#signal damage(amount)
@export var damage = 5
var level = 0
signal harvested


func harvest():
	if level == 2:
		harvested.emit()
		queue_free()
		return true
	else:
		return false

func _ready():
	#$AnimatedSprite2D.animation = animation_list.pick_random()
	pass



func _on_timer_timeout():
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("enemy"):
			#print(body)
			body.take_damage(damage)
			


func _on_timer_2_timeout():
	level += 1
	damage = damage * level
	$Area2D/CollisionShape2D.scale = Vector2(1,1) * (0.5 * level + 1)
	if level == 2:
		$Area2D/CPUParticles2D.color = Color(0.862745, 0.0784314, 0.235294, 1)
	if level == 3:
		queue_free()
	else:
		$AnimatedSprite2D.frame = level




func _on_area_2d_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		if event.button_index == 2:
			harvest()
