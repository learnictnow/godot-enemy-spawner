extends CharacterBody3D


var SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Create the target for the enemy to chase. Initially set it to chase itself.
@export var movement_target_node: Node3D = self

# Get the navigation agent and refer to it as this variable
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	# Run the actor setup function once enerything else has been setup.
	call_deferred("actor_setup")
	print(global_position)

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	navigation_agent.set_target_position(movement_target_node.global_position)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Check if we have reached our target
	if navigation_agent.is_navigation_finished():
		return
	else:
		# If we haven't reached out target update the target with it's new position. This means we can chase a moving object
		navigation_agent.set_target_position(movement_target_node.position)

	# Get our current position in terms of the entire level
	var current_agent_position: Vector3 = global_transform.origin
	# Get the position we are to move to next
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	# Update and Set the velocity of the object
	var new_velocity: Vector3 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * SPEED

	set_velocity(new_velocity)

	# Move the object
	move_and_slide()
