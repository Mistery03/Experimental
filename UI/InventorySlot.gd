extends Panel

@export var item:ItemData = null
@onready var texture_rect = $Border/TextureRect
@onready var label = $Label

var playerInventory:Control

var itemIndex = 0
var amount:int = 0

var dragging: bool = false
var drag_offset: Vector2

var original_position: Vector2  
var original_label_position: Vector2

signal dropped(slot, dropped_item, itemPos)
@onready var border = $Border

var mouse_pressed = false

func _ready():
	pass


func _process(delta):
	if item:
		texture_rect.texture = item.texture
		texture_rect.visible = true
		label.visible = true
		amount = clamp(amount,1,99)
		label.text = str(amount)
		texture_rect.set_z_index(1)
	else:
		texture_rect.visible = false
		label.visible = false
	
	"""if !playerInventory.isDragging:
			playerInventory.currSlot.texture_rect.global_position =  border.global_position + Vector2(10,10)
			playerInventory.currSlot.label.global_position = border.global_position + Vector2(75,75)"""
	
		
func _on_texture_rect_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				playerInventory.isDragging = true
				drag_offset = get_global_mouse_position() - get_global_position()
				texture_rect.set_z_index(100)
				playerInventory.currSlot = self
				playerInventory.currSlot.original_position = border.global_position + Vector2(10,10)
				playerInventory.currSlot.original_label_position =border.global_position + Vector2(75,75)
				
				
			else:
				if playerInventory.currSlot:	
					playerInventory.isDragging = false
					texture_rect.set_z_index(1)
					var gridPos = Vector2i(get_global_mouse_position()/custom_minimum_size)
					emit_signal("dropped", playerInventory.currSlot, item, amount, gridPos)
					#playerInventory.currSlot.texture_rect.global_position =  playerInventory.currSlot.border.global_position + Vector2(10,10)
					#playerInventory.currSlot.label.global_position = playerInventory.currSlot.border.global_position + Vector2(75,75)
					
				
			
			
	elif event is InputEventMouseMotion and playerInventory.isDragging:
		texture_rect.set_global_position(get_global_mouse_position() - drag_offset + Vector2(65,65))
		label.set_global_position(get_global_mouse_position() - drag_offset + Vector2(75,70))



func _on_mouse_entered():
	if mouse_pressed:
		pass
		#if playerInventory.parentMachine.currItemFromMachine:
			#playerInventory.insertAll(playerInventory.parentMachine.currItemFromMachine.item,playerInventory.parentMachine.currItemFromMachine.amount)
			#playerInventory.parentMachine.currItemFromMachine.isDragging = false
			#playerInventory.parentMachine.currItemFromMachine.item = null
			#playerInventory.parentMachine.currItemFromMachine = null
		
			
			

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			mouse_pressed = true
		else:
			mouse_pressed = false



