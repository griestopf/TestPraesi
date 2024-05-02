extends Node3D

@export var rotation_speed = 180
@export var camera_distance = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var rot_y = 0
var rot_x = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$camera_arm/camera.position.z = camera_distance
	var lr_axis = -Input.get_axis("turntable_left", "turntable_right")
	if lr_axis != 0:
		rot_y = rotation_speed * lr_axis * delta * PI / 180
	
	var ud_axis = Input.get_axis("turntable_down", "turntable_up")
	if ud_axis != 0:
		rot_x = rotation_speed * ud_axis * delta * PI / 180
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_vel = Input.get_last_mouse_velocity()
		rot_y =  rotation_speed * (-mouse_vel.x / 400) * delta * PI / 180
		rot_x =  rotation_speed * (-mouse_vel.y / 800) * delta * PI / 180

	rotate_y(rot_y)
	$camera_arm.rotate_x(rot_x)

	rot_y *= 0.965
	rot_x *= 0.965
