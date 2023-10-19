extends Node2D

@export var health_current = 20
@export var health_max = 20


func set_health(amount):
	health_current = amount
	health_max = amount
	

func change_health(amount):
	health_current += amount
	return health_current

func _process(_delta):
	if health_current <= 0:
		get_parent().queue_free()
