extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var playerScene = load('./Scenes/Player.tscn')
	var cubeScene = load('./Scenes/Cube.tscn')
	var gunScene = load('./Scenes/Gun.tscn')
	var random = RandomNumberGenerator.new()

	for i in 10:
		var cube = cubeScene.instance()
		random.randomize()
		var yChange = random.randf_range(0, 1)
		var xChange = random.randf_range(-10, 10)
		var zChange = random.randf_range(-10, 10)
		cube.translate(Vector3(xChange, 1+yChange+0.1, zChange))
		cube.scale = Vector3(1, 1+yChange, 1)
		add_child(cube)

	for i in 10:
		var gun = gunScene.instance()
		gun.translate(Vector3(0, 0, (i-5)*5))
		gun.set_rotation(Vector3(0, PI/2, 0))
		add_child(gun)

	var playerInstance = playerScene.instance()
	add_child(playerInstance)
