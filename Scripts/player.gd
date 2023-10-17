extends Node2D

@onready var plant_1: PackedScene = preload("res://Scenes/creature_1.tscn")
# Called when the node enters the scene tree for the first time.
func spawn(place):
	var plant = plant_1.instantiate()
	plant.position = place
	get_parent().add_child(plant)
	

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("mouse_one"):
		spawn(get_global_mouse_position())
		
