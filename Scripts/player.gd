extends Node2D

@onready var plant_1: PackedScene = preload("res://Scenes/pumpkin.tscn")
@onready var pause_menu = preload("res://Scenes/pause_menu.tscn")
@onready var play_area = get_tree().get_first_node_in_group("background").texture.get_size()/2
@export var scale_lean = 0.5
@export var damage = 50

# Called when the node enters the scene tree for the first time.
func take_damage(damage):
	$health.change_health(-damage)

func spawn(place):
	var plant = plant_1.instantiate()
	plant.position = place
	get_parent().add_child(plant)
	
func mouse_follow():
	$Camera2D.global_position = global_position + (get_global_mouse_position() - global_position) * scale_lean
	pass

func pause():
	var ui = pause_menu.instantiate()
	$Camera2D/ui.hide()
	$Camera2D.add_child(ui)
	
func _ready():
	$resource.resource_update.connect(_on_resource_update.bind())
	$Camera2D.limit_top = global_position.y - play_area.y
	$Camera2D.limit_right = global_position.x + play_area.x
	$Camera2D.limit_bottom = global_position.y + play_area.y
	$Camera2D.limit_left = global_position.x - play_area.x
	$resource.resource_add(5)	
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera2D/ui.resource_text_update(get_angle_to(get_global_mouse_position()))
	var mouse_pos = get_global_mouse_position()
	var mouse_angle = get_angle_to(mouse_pos)
	var unit = PI/6
	rotation = 7*unit
	#print(get_angle_to($Marker2D.global_position))
	#if mouse_angle > unit and mouse_angle > 4*unit:
		#$AnimatedSprite2D.play("back")
	#else:
		#$AnimatedSprite2D.play("front")
		#$AnimatedSprite2D.play("right")
		#$AnimatedSprite2D.flip_h = false
	#if mouse_angle > 0.9 and mouse_angle > 2.4:
		#$AnimatedSprite2D.play("back")
	#if mouse_angle > 2.4 and mouse_angle < 3.9:
		#$AnimatedSprite2D.play("right")
		#$AnimatedSprite2D.flip_h = true
	#if mouse_angle > 3.9 and mouse_angle < 5.4:
		#$AnimatedSprite2D.play("front")
	#if mouse_angle > 5.4 and mouse_angle > 0.9:
		#$AnimatedSprite2D.play("right")
		#$AnimatedSprite2D.flip_h = false
	#if mouse_angle < 2.1 and mouse_angle > 0.9:
		#$AnimatedSprite2D.play("front")
	#else:
		#$AnimatedSprite2D.play("right")
		#$AnimatedSprite2D.flip_h = true
	if get_tree().paused == false:
		$Camera2D/ui.show()
	
		if Input.is_action_just_pressed("mouse_one") and $resource.resource_spend(1):
			spawn(mouse_pos)
		if Input.is_action_just_pressed("escape"):
			pause()#$Camera2D.add_child("")
	else:
		$Camera2D/ui.hide()
	mouse_follow()
func _on_resource_update(new):
	$Camera2D/ui.resource_text_update(get_angle_to(get_global_mouse_position()))#new)


func _on_timer_timeout():
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("enemy"):
			#print(body)
			take_damage(body.damage)
			body.take_damage(damage)
