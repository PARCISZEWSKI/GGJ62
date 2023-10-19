extends Node2D

var animation_list = ["default", "new_animation", "new_animation_1"]
#signal damage(amount)
@export var damage = 10


func _ready():
	#$AnimatedSprite2D.animation = animation_list.pick_random()
	pass



func _on_timer_timeout():
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("enemy"):
			print(body)
			body.take_damage(damage)
			
