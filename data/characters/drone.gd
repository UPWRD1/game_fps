extends CharacterBody3D
#
##idle rotation
#var xlocation = randi_range(-180,180)
#var zlocation = randi_range(-180,180)
#var ylocation = randi_range(5,40)
##folowing player
##var harass = false
##var Player_Close = false #AI stops going toward player
##face direction of player
@onready var target = get_tree().get_node("player")
var rot_speed = 0.05
var speed = 5
const minimum_speed = 1
const max_speed = 10
const min_rot_speed = 0.005
const max_rot_speed = 0.05
##random move
var idle_speed = randf_range(minimum_speed, speed)
#var move_or_not = [true, true, false, true, true]
#var start_move = move_or_not[randi() % move_or_not.size()]
#
##var state: State
#
#func _ready():
#	$Timer.start()
#	#state = State.IDLE
#
#func _process(delta):
#	#print_debug(state)
#	if (state == State.RETREAT):
#		rot_speed = max_rot_speed
#		speed = max_speed - 2
#		var global_pos = self.global_transform.origin
#		var target_pos = target.global_transform.origin
#		var new_pos = self.global_transform.origin - Vector3(global_pos.x+xlocation, target_pos.y+ylocation, global_pos.z+zlocation)
#		var wtransform = self.global_transform.looking_at(Vector3(target_pos.x, global_pos.y, target_pos.z), Vector3.UP)
#		var wrotation = Quaternion(global_transform.basis.orthonormalized()).slerp(Quaternion(wtransform.basis.orthonormalized()), rot_speed)
#		self.global_transform = Transform3D(Basis(wrotation), global_pos)
#		velocity = new_pos.normalized() * speed * delta
#		move_and_collide(-velocity)
#	elif state == State.HARASS:
#		speed = max_speed
#		var global_pos = self.global_transform.origin
#		var target_pos = target.global_transform.origin
#		var wtransform = self.global_transform.looking_at(Vector3(target_pos.x, global_pos.y, target_pos.z), Vector3.UP)
#		var wrotation = Quaternion(global_transform.basis.orthonormalized()).slerp(Quaternion(wtransform.basis.orthonormalized()), rot_speed)
#		self.global_transform = Transform3D(Basis(wrotation), global_pos)
#		velocity = (target_pos - transform.origin).normalized() * speed  * delta
#		move_and_collide(velocity)
#	else: 
#		speed = idle_speed
#		rot_speed = min_rot_speed
#		var global_pos = self.global_transform.origin
#		var wtransform = self.global_transform.looking_at(Vector3(xlocation, global_pos.y, zlocation), Vector3.UP)
#		var wrotation = Quaternion(global_transform.basis.orthonormalized()).slerp(Quaternion(wtransform.basis.orthonormalized()), rot_speed)
#		self.global_transform = Transform3D(Basis(wrotation), global_pos)
#		velocity = global_transform.basis.z.normalized() * idle_speed * delta
#		move_and_collide(-velocity)
#   #move_and_slide()
#
#func _on_too_far(body):
#	if body.name == ("player"):
#		state = State.HARASS
#
#
#func _on_timer_timeout():
#	$Timer.set_wait_time(randf_range(1,3))
#	xlocation = randf_range(-180,180) 
#	zlocation = randf_range(-180,180)
#	ylocation = randf_range(5,40)
# #random speed of idle move
#	idle_speed = randf_range(minimum_speed, max_speed)
# #enemy will move or just look around
#	start_move = move_or_not[randi() % move_or_not.size()]
#	$Timer.start()
#
#	$Timer.start()
# # Replace with function body.
#
#
#func _on_enter_detect(body):
#	if body.name == ("player"):
#		state = State.HARASS # Replace with function body.
#
#func _on_too_close(body):
#	if body.name == ("player"):
#		state = State.RETREAT
#
#
#func _on_exit_detect(body):
#	if body.name == ("player"):
#		state = State.IDLE

func harass(delta):
	speed = max_speed
	var global_pos = self.global_transform.origin
	var target_pos = target.global_transform.origin
	var wtransform = self.global_transform.looking_at(Vector3(target_pos.x, global_pos.y, target_pos.z), Vector3.UP)
	var wrotation = Quaternion(global_transform.basis.orthonormalized()).slerp(Quaternion(wtransform.basis.orthonormalized()), rot_speed)
	self.global_transform = Transform3D(Basis(wrotation), global_pos)
	velocity = (target_pos - transform.origin).normalized() * speed  * delta
	move_and_collide(velocity)

func _on_state_machine_player_updated(state, delta):
	match state:
		"Harass":
			harass(delta)
