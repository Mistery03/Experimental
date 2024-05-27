extends GridContainer

@export var maxInventorySize:int
@export var inventorySlot:PackedScene
@export var inventoryList:Array[ItemData]
@export var playerInvetory:InitInventory
var itemList:Array
var currSlot
var tempItemDataHolder
# Called when the node enters the scene tree for the first time.
func _ready():
	initInventorySlot()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		displayInventory()
	
	

func initInventorySlot():
	for child in get_children():
		child.queue_free()
		
	for index in range(maxInventorySize):
		var slot = inventorySlot.instantiate()
		add_child(slot)
		slot.inventory = self
		


func displayInventory() -> void:
	var slots = get_children()  # Get all the slots in the inventory
	for i in range(min(len(slots), len(playerInvetory.playerInventory))):  # Ensure we don't go out of bounds
		var slot = slots[i]
		var item = playerInvetory.playerInventory[i]
		if item != null:
			slot.displayItem(item)  # Display the item in the slot
		else:
			slot.clearItem()  # Clear the slot if there's no item
		
