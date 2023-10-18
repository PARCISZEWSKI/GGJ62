extends Node2D

var animation_list = ["default", "new_animation", "new_animation_1"]

func _ready():
	$AnimatedSprite2D.animation = animation_list.pick_random()
	
