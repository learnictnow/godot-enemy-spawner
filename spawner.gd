extends Node3D

# Store the enemy to spawn, here is loads the default enemy but can be customised.
@export var spawner_enemy:PackedScene = load("res://enemy.tscn")

# Set the target object that the enemy will head towards (usually the player)
@export var spawner_target:Node3D = null

func _on_timer_timeout():
	# Create an enemy object
	var spawn_object = spawner_enemy.instantiate()
	
	#Move the enemy that has been created to the spawn point position in the world
	spawn_object.position = $SpawnPoint.global_position
	# Set the target for the enemy to follow
	spawn_object.movement_target_node = spawner_target
	
	# Make the enemy visible by adding it to the current scene (not the spawner)
	get_tree().current_scene.add_child(spawn_object)
