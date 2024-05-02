extends Node3D

@export var Scale = 2

# merges aabbs while avoiding to integrate the origin when merging 
# an out-of-center aabb with a zero-volume aabb
func aabb_mergev(a:AABB, b:AABB):
	if a.has_volume():
		if b.has_volume():
			return a.merge(b)
		return a
	# no matter if b has volume or not.
	return b;

# recursively traverse n and all of its children and accumulate a
# bounding box
func calc_aabb(n : Node):
	var aabb_ret = AABB()
	
	if n is MeshInstance3D:
		aabb_ret = aabb_mergev(aabb_ret, n.transform * n.mesh.get_aabb())

	for child in n.get_children():
		aabb_ret = aabb_mergev(aabb_ret, n.transform * calc_aabb(child))
		
	return aabb_ret


# Called when the node enters the scene tree for the first time.
func _ready():
	var aabb = calc_aabb($model_container)
	if aabb.has_volume():
		# Scale the model and position it in the middle
		var max_size = aabb.size[aabb.get_longest_axis_index()]
		var scale_fac = Scale / max_size
		$model_container.scale = Vector3(scale_fac, scale_fac, scale_fac)
		$model_container.position = -scale_fac * aabb.get_center()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
