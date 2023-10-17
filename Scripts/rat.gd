extends CharacterBody2D

@export var speed = 10
var focus = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	velocity = position.direction_to(focus) * speed
	move_and_slide()
	
func set_target(target):
	focus = target
