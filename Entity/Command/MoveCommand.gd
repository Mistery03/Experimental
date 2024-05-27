class_name MovementCommand
extends Command

class Params:
	var input:float
	
	func _init(input:float)->void:
		self.input = input

func execute(entity:Entity, data:Object = null) -> void:
	if data is Params:
		entity.move(data.input)
	
