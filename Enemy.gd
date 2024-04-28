extends CharacterBody3D


var SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var movement_target_node: Node3D = self

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	call_deferred("actor_setup")

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	navigation_agent.set_target_position(movement_target_node.global_position)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if navigation_agent.is_navigation_finished():
		return
	else:
		navigation_agent.set_target_position(movement_target_node.position)

	var current_agent_position: Vector3 = global_transform.origin
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	var new_velocity: Vector3 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * SPEED

	set_velocity(new_velocity)

	move_and_slide()


func _on_hit_area_3d_body_entered(body):
	if body.is_in_group("Target"):
		queue_free()
	pass # Replace with function body.
