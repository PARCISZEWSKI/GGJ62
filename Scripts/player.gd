extends Node2D

@onready var plant_1: PackedScene = preload("res://Scenes/creature_1.tscn")
@onready var play_area = get_tree().get_first_node_in_group("background").texture.get_size()/2
@export var scale_lean = 0.5


# Called when the node enters the scene tree for the first time.
func spawn(place):
	var plant = plant_1.instantiate()
	plant.position = place
	get_parent().add_child(plant)
	
func mouse_follow():
	$Camera2D.global_position = global_position + (get_global_mouse_position() - global_position) * scale_lean
	pass

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
	mouse_follow()
	if Input.is_action_just_pressed("mouse_one") and $resource.resource_spend(1):
		spawn(get_global_mouse_position())
		
func _on_resource_update(new):
	$Camera2D/ui.resource_text_update(new)
