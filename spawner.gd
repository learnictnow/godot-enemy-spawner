extends Node3D

@export var spawner_enemy:PackedScene = load("res://Enemy.tscn")
@export var spawner_target:Node3D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if spawner_target == null:
		print("WARNING SPAWNER TARGET NOT SET")
		
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var spawn_object = spawner_enemy.instantiate()
	spawn_object.movement_target_node
	
	var num_spawns = $SpawnPositions.get_child_count()
	var rand_spawn_pos = randi_range(0,num_spawns-1)
	spawn_object.position = $SpawnPositions.get_child(rand_spawn_pos).global_position
	spawn_object.SPEED = randi_range(3,10)
	
	#spawn_object.position = $SpawnPositions/Marker3D.global_position
	spawn_object.movement_target_node = spawner_target
	#get_tree().root.add_child(spawn_object)
	add_child(spawn_object)
	pass # Replace with function body.
