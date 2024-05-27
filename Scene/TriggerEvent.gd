extends Area2D
@onready var command_manager = $CommandManager

func _on_body_entered(body):
	if body is Player:
		body.setController(command_manager.init(body))
		print("Controller disabled")
		
	"""if body is Player:
		print("AI mode")
		body.setController(AiController.new(body))"""
