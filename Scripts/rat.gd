extends CharacterBody2D

@export var speed = 10
@onready var focus = get_tree().get_first_node_in_group("player")

var direction = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _physics_process(delta):
	direction = position.direction_to(focus.global_position)
	velocity = direction * speed
	move_and_slide()
	
func set_target(target):
	focus = target
