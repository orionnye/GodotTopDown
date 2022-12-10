extends Camera

# Called when the node enters the scene tree for the first time.
export var cameraRotation = Vector3(-1.221731, 3.141593, 0)
export var cameraOffset = Vector3(0, 10, -3)

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var this = $"."
	var player = $"./.."
	var playerOffset = player.rotation
	this.global_transform.origin = Vector3(0, 40, -20)
#	this.set_global_rotation(cameraRotation)
	this.rotation = cameraRotation - playerOffset
	this.transform.origin = cameraOffset.rotated(Vector3(0, 1, 0), -player.rotation.y )
