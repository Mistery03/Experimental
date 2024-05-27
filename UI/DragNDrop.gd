extends TextureButton
var isDragging:bool

var original_position : Vector2 = position
var oriTex = texture_normal
@onready var texture_rect = $".."


func _get_drag_data(at_position):
	var preview_texture = TextureRect.new()
 
	preview_texture.texture = texture_normal
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30,30)
 
	var preview = Control.new()
	preview.add_child(preview_texture)
 
	set_drag_preview(preview)
	visible = false

	#texture_normal = null
	return preview_texture.texture

func _can_drop_data(at_position, data):
	return true

func _drop_data(at_position, data):
	print(data)
	print(_can_drop_data(at_position, data))
	if _can_drop_data(at_position, data):
		texture_normal = data
	else:
		texture_normal = oriTex
		visible = true
		#texture = data
		
		#position = original_position

func _notification(notification_type):
	match notification_type:
		NOTIFICATION_DRAG_END:
			if texture_normal:
				visible = true
			

