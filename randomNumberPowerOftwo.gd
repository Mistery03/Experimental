extends Node
# Function to generate a random power of 2 with a minimum of 8 (2^3) and a maximum of 128 (2^7)
func random_power_of_2(min_power: int = 3, max_power: int = 7) -> int:
	# Ensure random seed is different each run
	randomize()
	
	# Generate a random integer between min_power and max_power (inclusive)
	var exponent = randi() % (max_power - min_power + 1) + min_power
	
	# Calculate 2^exponent
	return int(pow(2, exponent))

func _ready():
	# Example usage
	var min_exponent = 3
	var max_exponent = 7
	for i in range(10):  # Generate 10 random powers of 2 for demonstration
		var random_value = random_power_of_2(min_exponent, max_exponent)
		print("Random power of 2: ", random_value)
