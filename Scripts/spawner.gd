extends Node2D

var enemy_1 = preload("res://Scenes/rat.tscn")
var enemy_2 = preload("res://Scenes/bat.tscn")
@export var wave = 0
@export var amount = 1
@onready var area = get_tree().get_first_node_in_group("background")
@onready var play_area = area.texture.get_size()/2

func spawn(monster, number):
	var top = Vector2(randi_range(area.global_position.x - play_area.x - 20, area.global_position.x + play_area.x  + 20), area.global_position.y - play_area.y - 20)
	var right = Vector2(area.global_position.x + play_area.x  + 20, randi_range(area.global_position.y - play_area.y - 20, area.global_position.y + play_area.y  + 20))
	var bottom = Vector2(randi_range(area.global_position.x - play_area.x - 20, area.global_position.x + play_area.x  + 20), area.global_position.y + play_area.y + 20) 
	var left = Vector2(area.global_position.x - play_area.x - 20, randi_range(area.global_position.x - play_area.x - 20, area.global_position.x + play_area.x  + 20))
	var position_list = [top, right, bottom, left]
	for i in number:
		var enemy = monster.instantiate()
		#enemy.set_target(target)
		
		enemy.global_position = position_list.pick_random()#position_list[randi_range(0, len(position_list) - 1 )]
		get_parent().add_child(enemy)

func _on_timer_timeout():
	wave += 1
	if wave % 10 == 0:
		amount += 1
	spawn(enemy_1, amount)
	if wave > 10:
		spawn(enemy_2, amount - 1)
