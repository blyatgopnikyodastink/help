extends KinematicBody2D


signal tween_completed

enum {DEFAULT, INACTIVE}

const ACCEL = 500
const MAX_SPEED = 200
const FRICTION = 500
const TWEEN_TIME := 0.5

var velocity := Vector2.ZERO
var state := DEFAULT

onready var anim_tree := $AnimationTree
onready var anim_state: AnimationNodeStateMachinePlayback = anim_tree.get("parameters/playback")


func _ready() -> void:
	anim_tree.active = true
	

func _physics_process(delta):
	match state:
		DEFAULT:
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
		INACTIVE:
			pass


func set_cam_limits(limits: Rect2) -> void:
	$Camera2D.limit_left = limits.position.x
	$Camera2D.limit_top = limits.position.y
	$Camera2D.limit_right = limits.end.x
	$Camera2D.limit_bottom = limits.end.y
	

func tween_cam_limits(old: Rect2, new: Rect2) -> void:
	state = INACTIVE
	$Tween.interpolate_property($Camera2D, "limit_left", old.position.x, new.position.x, TWEEN_TIME)
	$Tween.interpolate_property($Camera2D, "limit_top", old.position.y, new.position.y, TWEEN_TIME)
	$Tween.interpolate_property($Camera2D, "limit_right", old.end.x, new.end.x, TWEEN_TIME)
	$Tween.interpolate_property($Camera2D, "limit_bottom", old.end.y, new.end.y, TWEEN_TIME)
	$Tween.start()


func _on_Tween_tween_all_completed() -> void:
	state = DEFAULT
	emit_signal("tween_completed")
