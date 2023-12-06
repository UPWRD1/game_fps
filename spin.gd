extends SpotLight3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rot_speed = rad_to_deg(5)
	var cv = rotation_degrees.y  # 30 deg/sec
	rotation_degrees.y += rot_speed * delta
