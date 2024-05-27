extends TextureButton

var isDragging:bool

func _get_drag_data(at_position):
	var preview_texture = TextureRect.new()
 
	preview_texture.texture = texture_normal
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(100,100)
	preview_texture.position = Vector2(-50,-50)
	preview_texture.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
 
	var preview = Control.new()
	preview.add_child(preview_texture)
 
	set_drag_preview(preview)
	visible = false
	isDragging = true
	#texture_normal = null
 
	return preview_texture.texture

func _can_drop_data(at_position, data):
	return data

func _drop_data(at_position, data):
	#if _can_drop_data(at_position, data):
	texture_normal = data.texture_normal

func _notification(notification_type):
	match notification_type:
		NOTIFICATION_DRAG_END:
			visible = true
	
