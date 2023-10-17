extends Node2D

var plant_1 = preload("res://Scenes/creature_1.tscn")
# Called when the node enters the scene tree for the first time.
func spawn(place):
	plant_1.instantiate()
	plant_1.position = place

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("mouse_one"):
		spawn(get_global_mouse_position())
		
