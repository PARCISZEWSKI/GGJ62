extends CharacterBody2D

@export var speed = 500
@onready var target = Vector2.ZERO#$main/player.global_position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	velocity = position.direction_to(target) * speed * delta
	move_and_slide()
	
	

