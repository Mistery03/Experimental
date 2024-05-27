class_name MoveEntityCommand
extends CommandBase

var parent:Entity

@export var moveUnit:int
@export var duration:float
	

func moveEntityCommand(parent:Entity):
	self.parent = parent

func execute(data = null) -> void:
	if data!= null:
		parent.advance(data)
	else:
		parent.advance(moveUnit)	
		#await parent.get_tree().create_timer(duration).timeout
		#onCommandExecuted.emit()

func stop():
	parent.advance(0)
	if parent.controller == null:
		parent.setController(UserController.new(parent))
	print("controller enabled")
