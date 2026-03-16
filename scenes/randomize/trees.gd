extends Node3D

@export var spawn_radius: float = 300.0  # Area around parent to place trees
@export var min_distance: float = 2.5   # Minimum space between trees
@export var height_offset: float = 0.1  # Small offset above ground
@export var max_slope: float = 35.0    # Maximum slope angle trees can spawn on (degrees)
@export var raycast_height: float = 100.0  # How high above to start checking

func _ready():
	randomize_tree_positions()

func spawnn():
	var noise = FastNoiseLite.new()

func randomize_tree_positions():
	var space_state = get_world_3d().direct_space_state
	var placed_positions: Array[Vector3] = []
	var center = global_transform.origin
	
	for tree in get_children():
		if tree is Node3D:
			var attempts = 0
			var position_found = false
			var final_position = Vector3.ZERO
			
			while not position_found and attempts < 50:
				attempts += 1
				
				# Generate random position in circle
				var random_dir = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
				var random_dist = randf_range(0, spawn_radius)
				var x = center.x + random_dir.x * random_dist
				var z = center.z + random_dir.y * random_dist
				
				# Raycast down to find terrain
				var from = Vector3(x, center.y + raycast_height, z)
				var to = Vector3(x, center.y - raycast_height, z)
				var query = PhysicsRayQueryParameters3D.create(from, to)
				query.collide_with_areas = true
				
				var result = space_state.intersect_ray(query)
				if result:
					# Check slope
					var normal = result.normal
					var slope_angle = rad_to_deg(acos(normal.dot(Vector3.UP)))
					
					if slope_angle <= max_slope:
						final_position = result.position + Vector3.UP * height_offset
						
						# Check distance from other trees
						position_found = true
						for existing_pos in placed_positions:
							if final_position.distance_to(existing_pos) < min_distance:
								position_found = false
								break

				if position_found or attempts >= 50:
					if position_found:
						tree.global_position = final_position
						placed_positions.append(final_position)
						# Preserve original rotation and scale
						tree.rotation = tree.rotation
						tree.scale = tree.scale
					break
