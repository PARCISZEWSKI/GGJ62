extends Node2D

@export var health_current = 0
@export var health_max = 0


func set_health(amount):
	health_current = amount
	health_max = amount
	

func change_health(amount):
	health_current += amount
	return health_current

