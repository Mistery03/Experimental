class_name PlayerController
extends Node

var player:Player

var movementCommand :MovementCommand 

func _init(player:Player)->void:
	self.player = player
	movementCommand = MovementCommand.new()


