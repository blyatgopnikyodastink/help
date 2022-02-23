extends KinematicBody2D


const ACCEL = 500
const MAX_SPEED = 200
const FRICTION = 500

var velocity := Vector2.ZERO

onready var anim_tree := $AnimationTree
onready var anim_state: AnimationNodeStateMachinePlayback = anim_tree.get("parameters/playback")


func _ready() -> void:
	anim_tree.active = true
	

func _physics_process(delta):
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	if not input_vector == Vector2.ZERO:
		anim_tree.set("parameters/idle/blend_position", input_vector)
		anim_tree.set("parameters/run/blend_position", input_vector)
		anim_state.travel("run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCEL * delta)
		for area in $SCDetector.get_overlapping_areas():
			if sign(area.direction.x) == sign(velocity.x) and velocity.x != 0 or sign(area.direction.y) == sign(velocity.y) and velocity.y != 0:
				area.change_scene(global_position)
				return
	else:
		anim_state.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)
