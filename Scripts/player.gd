extends Node2D

@onready var plant_1: PackedScene = preload("res://Scenes/pumpkin.tscn")
@onready var pause_menu = preload("res://Scenes/pause_menu.tscn")
@onready var over_menu = preload("res://Scenes/game_over.tscn")
@onready var play_area = get_tree().get_first_node_in_group("background").texture.get_size()/2
@export var scale_lean = 0.5
@export var damage = 50
var dead = false
var score = 0

const directions = [
	"right",
	"back",
	"right",
	"front",
]

# Called when the node enters the scene tree for the first time.
func take_damage(damage):
	$health.change_health(-damage)
	$Camera2D/ui.health_text_update($health.health_current, $health.health_max)

func spawn(place):
	$AudioStreamPlayer2D.play()
	var plant = plant_1.instantiate()
	plant.position = place
	plant.harvested.connect(_on_harvest.bind())
	get_parent().add_child(plant)
	
func mouse_follow():
	$Camera2D.global_position = global_position + (get_global_mouse_position() - global_position) * scale_lean
	pass

func pause():
	var ui = pause_menu.instantiate()
	$Camera2D/ui.hide()
	$Camera2D.add_child(ui)

func game_over():
	var ui = pause_menu.instantiate()
	$Camera2D/ui.hide()
	$Camera2D.add_child(ui)
	$Camera2D/pause_menu.game_over(score)
	
	
	
func _ready():
	$resource.resource_update.connect(_on_resource_update.bind())
	$Camera2D.limit_top = global_position.y - play_area.y
	$Camera2D.limit_right = global_position.x + play_area.x
	$Camera2D.limit_bottom = global_position.y + play_area.y
	$Camera2D.limit_left = global_position.x - play_area.x
	$resource.resource_add(1)
	$Camera2D/ui.health_text_update($health.health_current, $health.health_max)
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var mouse_pos = get_local_mouse_position()
	
	var direction_mouse = mouse_pos.normalized()
	var direction_id = int(4.0 * (direction_mouse.rotated(PI / 4.0).angle() + PI) / TAU)
	$AnimatedSprite2D.play(directions[direction_id])
	if direction_id == 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	if get_tree().paused == false:
		$Camera2D/ui.show()
	
		if (Input.is_action_just_pressed("mouse_one") and $resource.resource_spend(-1)):
			spawn(get_global_mouse_position())
		if Input.is_action_just_pressed("escape"):
			pause()#$Camera2D.add_child("")
	else:
		$Camera2D/ui.hide()
	mouse_follow()
	
func _on_resource_update(new, add):
	if add > 0:
		score += add
	$Camera2D/ui.resource_text_update(new)
	$Camera2D/ui.score_text_update(score)

func _on_harvest():
	$resource.resource_add(2)

func _on_timer_timeout():
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("enemy"):
			#print(body)
			take_damage(body.damage)
			body.take_damage(damage)


func _on_health_death():
	if !dead:
		game_over()
		dead  == true
	#game_over()
	
