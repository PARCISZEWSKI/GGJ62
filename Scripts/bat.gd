extends CharacterBody2D

@export var speed = 25
@onready var focus = get_tree().get_first_node_in_group("player")
@onready var play_area = get_tree().get_first_node_in_group("background").texture.get_size()/2
#var animation_list = ["default", "new_animation"]
@export var damage = 10
var direction = Vector2.ZERO
var dead = false

func out_of_bounds():
	var top = focus.global_position.y - play_area.y > global_position.y
	var right = focus.global_position.x + play_area.x < global_position.x
	var bottom = focus.global_position.y + play_area.y < global_position.y
	var left = focus.global_position.x - play_area.x > global_position.x
	if top or right or bottom or left:
		return true
	else:
		return false


func take_damage(damage):
	$health.change_health(-damage)
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")
	if (focus.global_position.x + play_area.x)/2 > global_position.x:
		$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
	#$AnimatedSprite2D.animation = animation_list.pick_random()
	pass


func _physics_process(delta):
	if dead == true:
		direction = -position.direction_to(focus.global_position)
		velocity = direction * speed * 2
		move_and_slide()
		if out_of_bounds():
			#print("Huge succes")
			queue_free()
			
	else:
		direction = position.direction_to(focus.global_position)
		velocity = direction * speed
		move_and_slide()
	
	
func set_target(target):
	focus = target
	


func _on_health_death():
	if !dead:
		$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
		$CollisionShape2D.disabled = true
	dead = true
