class_name TreeGeneration
extends Node2D

@export var maxNodes:int = 5
# Adjacency list represented as a dictionary
var adjacency_list = {}
# Node positions for visualization
var node_positions = {}

var default_font : Font = ThemeDB.fallback_font;
# Function to add a node
func add_node(node):
	if not adjacency_list.has(node):
		adjacency_list[node] = []

# Function to add an edge
func add_edge(node1, node2):
	if adjacency_list.has(node1) and adjacency_list.has(node2):
		adjacency_list[node1].append(node2)
		adjacency_list[node2].append(node1) # For an undirected graph

# Function to remove an edge
func remove_edge(node1, node2):
	if adjacency_list.has(node1) and adjacency_list.has(node2):
		adjacency_list[node1].erase(node2)
		adjacency_list[node2].erase(node1) # For an undirected graph

# Function to remove a node
func remove_node(node):
	if adjacency_list.has(node):
		for neighbor in adjacency_list[node]:
			adjacency_list[neighbor].erase(node)
		adjacency_list.erase(node)

# Function to print the adjacency list
func print_adjacency_list():
	for node in adjacency_list.keys():
		print("%s: %s" % [node, adjacency_list[node]])

# Function to check if the graph is a tree using E = V - 1 method
func is_tree():
	var num_nodes = adjacency_list.size()
	var num_edges = 0
	
	for node in adjacency_list.keys():
		num_edges += adjacency_list[node].size()
	
	# Each edge is counted twice (once from each node), so divide by 2
	num_edges /= 2
	
	if num_edges != num_nodes - 1:
		return false

	# Check if the graph is connected
	var visited = {}
	var start_node = adjacency_list.keys()[0]
	dfs(start_node, visited)
	
	return visited.size() == num_nodes

# Depth-first search to check connectivity
func dfs(node, visited):
	visited[node] = true
	for neighbor in adjacency_list[node]:
		if not visited.has(neighbor):
			dfs(neighbor, visited)

# Function to print the parent of a given node
func print_parent(node):
	for parent_node in adjacency_list.keys():
		if node in adjacency_list[parent_node]:
			print("%s's parent is %s" % [node, parent_node])
			return
	print("%s has no parent (it's a root node or disconnected)" % node)

# Function to print the children of a given node
func print_children(node):
	if adjacency_list.has(node):
		print("%s's children are: %s" % [node, adjacency_list[node]])
	else:
		print("%s does not exist in the graph" % node)

# Function to print all leaf nodes (nodes with no children)
func print_leafs():
	for node in adjacency_list.keys():
		if adjacency_list[node].size() == 1:
			print("%s is a leaf node" % node)

# Function to create a random spanning tree with a maximum degree of 4
func create_spanning_tree(max_nodes):
	randomize()  # Ensure random seed is different each run

	# Create nodes
	for i in range(max_nodes):
		add_node(str(i))

	# List to keep track of added nodes to ensure the tree property
	var added_nodes = [str(0)]

	# Create a random spanning tree
	for i in range(1, max_nodes):
		var new_node = str(i)
		var existing_node = added_nodes[randi() % added_nodes.size()]

	# Ensure the existing node does not exceed a degree of 4
		while adjacency_list[existing_node].size() >= 4:
			existing_node = added_nodes[randi() % added_nodes.size()]

		add_edge(new_node, existing_node)
		added_nodes.append(new_node)
# Function to draw the tree
func _draw():
	# Draw edges
	for node in adjacency_list.keys():
		for neighbor in adjacency_list[node]:
	# Ensure each edge is drawn only once
			if node_positions.has(node) and node_positions.has(neighbor):
				if node < neighbor:
					draw_line(node_positions[node], node_positions[neighbor], Color(0, 0, 0), 2)

	# Draw nodes
	for node in node_positions.keys():
		draw_circle(node_positions[node], 10, Color(1, 0, 0))
		#draw_string(get_font("font"), node_positions[node] + Vector2(12, 0), node, Color(0, 0, 0))
		
func print_degrees():
	for node in adjacency_list.keys():
		var degree = adjacency_list[node].size()
		print("%s has a degree of %d" % [node, degree])

func getAdjacencyDegreeList():
	var degreeList = {}
	degreeList.clear()
	for node in adjacency_list.keys():
		var degree = adjacency_list[node].size()
		degreeList[node] = []
		degreeList[node].append(degree)
	return degreeList

func getAdjacencyDegree(key:int):
	return adjacency_list.get(str(key)).size()

func getFirstNode()->int:
	return int(adjacency_list.keys()[0])


"""func _ready():
	create_spanning_tree(maxNodes)
	
	
	# Example usage
	#add_node("A")
	#add_node("B")
	#add_node("C")
	#add_node("D")
	#add_edge("A", "B")
	#add_edge("A", "C")
	#add_edge("B", "D")
	
	print_adjacency_list()
	
	# Check if the graph is a tree
	if is_tree():
		print("The graph is a tree")
	else:
		print("The graph is not a tree")
	
	# Print parent, children, and leaf nodes
	#print_parent("B")
	#print_children("A")
	print_leafs()
	print_degrees()
	var degreeList = getAdjacencyDegreeList()
	for node in degreeList.keys():
		print(degreeList.get(node)[0])
	
	# Removing an edge and a node
	#remove_edge("A", "B")
	#remove_node("C")
	
	#print("After modifications:")
	#print_adjacency_list()"""

