extends Node3D

@export var selected_spawn_object:PackedScene = null
@export var spawner_A:PackedScene = null
@export var spawner_B:PackedScene = null
@export var spawner_C:PackedScene = null
 	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if Input.is_action_just_pressed("primary_mouse"):
		#var camera = get_tree().get_nodes_in_group("Camera")[0]
		var camera = $Camera3D
		var mousePos = get_viewport().get_mouse_position()
		var rayLength = 100
		var from = camera.project_ray_origin(mousePos)
		var to = from + camera.project_ray_normal(mousePos) * rayLength
		var space = get_world_3d().direct_space_state
		var rayQuery = PhysicsRayQueryParameters3D.new()
		rayQuery.from = from
		rayQuery.to = to
		rayQuery.collide_with_bodies = true
		var result = space.intersect_ray(rayQuery)
		print(result)
		
		if selected_spawn_object != null and not result.is_empty():
			var spawn_object = selected_spawn_object.instantiate()
			spawn_object.position = result.position
			add_child(spawn_object)


func _on_control_spawner_selection(selected_spawner):
	if selected_spawner == "A":
		selected_spawn_object = spawner_A
	elif selected_spawner == "B":
		selected_spawn_object = spawner_B
	elif selected_spawner == "C":
		selected_spawn_object = spawner_C
	print(selected_spawn_object)
	pass # Replace with function body.
