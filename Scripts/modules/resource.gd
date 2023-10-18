extends Node2D

signal resource_update(new)
var resource_current = 0

func resource_add(amount):
	resource_current += amount
	resource_update.emit(resource_current)
	
func resource_spend(amount):
	if amount <= resource_current:
		resource_current -= amount
		resource_update.emit(resource_current)
		return true
	else:
		return false
