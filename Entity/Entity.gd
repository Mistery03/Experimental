class_name Entity
extends CharacterBody2D

@export var entityStat:EntityStat

var horizontalInput:float = 0

func advance(value:float)->void:
	horizontalInput = value


