# physics_helper.gd
extends Node

# Applies a force to a RigidBody3D
static func apply_force(body: RigidBody3D, force: Vector3, position: Vector3 = Vector3.ZERO) -> void:
	body.apply_force(force, position)

# Applies an impulse (instant force)
static func apply_impulse(body: RigidBody3D, impulse: Vector3, position: Vector3 = Vector3.ZERO) -> void:
	body.apply_impulse(impulse, position)

# Teleports a physics body smoothly (avoids tunneling)
static func teleport(body: PhysicsBody3D, new_position: Vector3) -> void:
	body.global_position = new_position
	PhysicsServer3D.body_set_state(body.get_rid(), PhysicsServer3D.BODY_STATE_TRANSFORM, body.global_transform)

# Checks if two bodies are colliding
static func are_colliding(body1: PhysicsBody3D, body2: PhysicsBody3D) -> bool:
	return body1.collides_with(body2)

# Sets custom gravity for a body (e.g., low-gravity zones)
static func set_custom_gravity(body: RigidBody3D, gravity: float) -> void:
	body.gravity_scale = gravity
