extends CharacterBody3D


#@export var crouch_enabled = true
@export var slide_enabled = true

@export var base_speed = 12
@export var sprint_speed = 16
@export var jump_velocity = 5
@export var sensitivity = 0.1
@export var accel = 10
@export var crouch_speed = 3
@export var slide_speed = 0
@export var wall_run_tilt_angle : float = 45.0
@export var dash_dist = 10

signal significant_action

enum State {
	WALKING,
	JUMPING,
	SLIDING,
	WALL_RUNNING,
	WALL_JUMPING,
	SLAMMING,
	FALLING,
}

var state: State

var is_sigact = false
var speed = base_speed

var camera_fov_extents = [75.0, 85.0] #index 0 is normal, index 1 is sprinting
var base_player_y_scale = 1.0
var crouch_player_y_scale = 0.75
var wall_normal
var w_runnable = false

var slide_started = false  # New variable to track if slide has started

var jump_count = 0

@onready var parts = {
	"head": $head,
	"camera": $head/camera,
	"camera_animation": $head/camera/camera_animation,
	"body": $body,
	"collision": $collision,
	"timer": $Timer,
	"glitch_shader": $head/camera/CanvasLayer/glitch,
	"bw_shader": $head/camera/CanvasLayer/bw,
	"hud_cam": $head/camera/Hud/CanvasLayer/SubViewportContainer/SubViewport/Camera3D,
	"gun1": $head/camera/pew,
	"raycast": $head/camera/RayCast3D
}

@onready var player_vars = get_node("/root/PlayerVars")


@onready var world = get_parent()
@onready var timer = $Timer

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var direction = Vector3()

var current_tilt_angle: float
var wallrun_angle = 15
var side = Vector3()

func show_glitch():
	if is_sigact:
		parts.bw_shader.visible = true
		parts.glitch_shader.visible = true
	else:
		parts.glitch_shader.visible = false
		parts.bw_shader.visible = false

func wall_run(delta):
	if w_runnable and is_on_wall():
		wall_normal = get_slide_collision(0).get_normal()
		velocity.y = 0
		side = wall_normal.cross(Vector3.UP)
		jump_count = 0
		direction = -wall_normal * speed
		#wall_running = true
		state = State.WALL_RUNNING
		speed = sprint_speed
		parts.camera.fov = lerp(parts.camera.fov, camera_fov_extents[1], 10*delta)
		if Input.is_action_just_pressed("move_jump"):
			if state == State.WALL_RUNNING:
				state = State.WALL_JUMPING
				significant_action.emit()
				velocity += wall_normal * speed
				velocity.y += 3
				velocity.z += 3
				w_runnable = true
				jump_count = 0
		if not is_on_floor():
			var to_rot = 0
			if abs(fmod(parts.head.rotation_degrees.y, 360.0)) < 180.0:
				if side.dot(Vector3.RIGHT) > 0:
					to_rot = wallrun_angle
				else:
					to_rot = -wallrun_angle
			else:
				if side.dot(Vector3.RIGHT) < 0:
					to_rot = wallrun_angle
				else:
					to_rot = -wallrun_angle
			#print(to_rot , " " , abs(fmod(parts.head.rotation_degrees.y, 360.0)))
		# Set the rotation directly
			parts.camera.rotation_degrees.z = lerp(parts.camera.rotation_degrees.z, float(to_rot), 0.1)
		parts.camera.rotation_degrees.y = lerp(parts.camera.rotation_degrees.x, 0.0, 0.1)

func _reset_camera_rotation():
	parts.camera.rotation_degrees.z = lerp(parts.camera.rotation_degrees.z, 0.0, 0.1)

func _ready():
	world.pause.connect(_on_pause)
	world.unpause.connect(_on_unpause)
	
	parts.camera.current = true

func _process(delta):
	wall_run(delta)
	show_glitch()
	break_sigact()
	if Input.is_action_pressed("move_sprint") and not (state == State.WALL_RUNNING):
		if Input.is_action_just_pressed("move_jump"):
			state = State.JUMPING
			jump()
			significant_action.emit()
		var slide_direction = Vector3()
		if !slide_started:
			slide_direction = Vector3(direction.x, 0, direction.z).normalized()
			slide_started = true

		#sliding = true
		state = State.SLIDING
		speed = slide_speed

		parts.camera.fov = lerp(parts.camera.fov, camera_fov_extents[1], 10*delta)
		parts.body.scale.y = lerp(parts.body.scale.y, crouch_player_y_scale, 20*delta) #change this to starting a crouching animation or whatever
		parts.collision.scale.y = lerp(parts.collision.scale.y, crouch_player_y_scale, 20*delta)
		velocity.x += (slide_direction.x * slide_speed) / (10 * delta)
		velocity.z += (slide_direction.z * slide_speed) / (10 * delta)
		
	else:
		state = State.WALKING
		speed = base_speed
		sensitivity = 0.1


		if slide_enabled:
			parts.camera.fov = lerp(parts.camera.fov, camera_fov_extents[0], 10*delta)

func slam():
	if not is_on_floor() and (state == State.SLAMMING):
		significant_action.emit()
		velocity = Vector3.DOWN * 100
		state = State.SLAMMING

func jump():
	if is_on_floor() or jump_count < 2 and state == State.JUMPING:
		velocity.y += jump_velocity
		jump_count += 1
		timer.start()

func fall(delta):
	velocity.y -= (gravity * 1.3) * delta
	w_runnable = true
	state = State.FALLING

func move(delta):
	velocity.x = lerp(velocity.x, direction.x * speed, accel * delta)
	velocity.z = lerp(velocity.z, direction.z * speed, accel * delta)
			#jump_count = 0

func animation_bob(input_dir):
	if input_dir and is_on_floor() and not state == State.SLIDING:
		parts.camera_animation.play("head_bob", 0.5)
	else:
		parts.camera_animation.play("reset", 0.5)

func look(event):
	parts.head.rotation_degrees.y -= event.relative.x * sensitivity
	parts.head.rotation_degrees.x -= event.relative.y * sensitivity
	parts.head.rotation.x = clamp(parts.head.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func reload():
	await get_tree().create_timer(0.2).timeout
	PlayerVars.ammo = 5

func shoot():
	if PlayerVars.ammo > 0:
		var ani = parts.gun1.get_node("AnimationPlayer")
		PlayerVars.ammo -= 1
		ani.play("default", 0)
		await get_tree().create_timer(0.5).timeout
	else:
		reload()
	
func _physics_process(delta):
	wall_run(delta)
	do_sigact()
	if not is_on_floor():
		fall(delta)
	else:
		if not state == State.SLIDING:
			state = State.WALKING
			move(delta)
			#jump_count = 0
		w_runnable = false
		jump_count = 0  # Reset jump count when the jump key is released
	
	if not is_on_wall():
		_reset_camera_rotation()
		
	if Input.is_action_just_pressed("move_crouch"):
		if not is_on_floor() and not (state == State.WALL_RUNNING):
			state = State.SLAMMING
			slam()
		# Reset camera rotation when on floor

	if Input.is_action_just_pressed("move_jump"):
		if state == State.WALL_RUNNING:
			pass
		else:
			state = State.JUMPING
			jump()

	if Input.is_action_just_pressed("mouse1"):
		shoot()

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	direction = input_dir.normalized().rotated(-parts.head.rotation.y)
	direction = Vector3(direction.x, 0, direction.y)

	if state == State.WALL_RUNNING:
		move(delta)

	# bob head
	animation_bob(input_dir)

	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		if !world.paused and not state == State.WALL_RUNNING:
			look(event)

func _on_pause():
	pass

func _on_unpause():
	pass

func _on_timer_timeout():
	w_runnable = false # Replace with function body.

func break_sigact():
	if is_sigact:
		if Input.is_action_just_pressed("move_crouch"):
			is_sigact = false
			Engine.time_scale = 1

func do_sigact():
	if PlayerVars.ability >= 5:
		if Input.is_action_pressed("do_sigact"):
			is_sigact = true
			Engine.time_scale = 0.1
			#velocity = Vector3.ZERO
			await get_tree().create_timer(0.1).timeout
			while Engine.time_scale < 1:
				Engine.time_scale = lerp(Engine.time_scale, 1.0, 0.5)
				PlayerVars.ability -= 1
			is_sigact = false
			PlayerVars.ability = 0

func _on_significant_action():
	PlayerVars.ability += 1
	print("sigact ", PlayerVars.ability)
