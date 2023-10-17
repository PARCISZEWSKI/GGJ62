extends Node2D

var enemy_1 = preload("res://Scenes/rat.tscn")



func spawn(monster, target):
	var enemy = monster.instantiate()
	enemy.set_target(target)
	enemy.global_position =Vector2(randi_range(0, get_viewport_rect().size.x), randi_range(-get_viewport_rect().size.y, 0))
	#et_parent().add_child(enemy)

func _on_timer_timeout():
	spawn(enemy_1, get_parent().get_node("player"))
