extends Node2D

signal resource_update(new, add)
var resource_current = 0

func resource_add(amount):
	resource_current += amount
	resource_update.emit(resource_current, amount)
	
func resource_spend(amount):
	if -amount <= resource_current:
		resource_current += amount
		resource_update.emit(resource_current, amount)
		return true
	else:
		return false



func _on_timer_timeout():
	resource_add(1)
