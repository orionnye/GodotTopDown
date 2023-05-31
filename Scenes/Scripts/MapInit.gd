extends Node3D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var cubeScene = load('res://Scenes/Prefabs/InteractiveCube.tscn')
	var gunScene = load('res://Scenes/Prefabs/Gun.tscn')
	var mudTile = load('res://Scenes/Prefabs/Tiles/MudTile.tscn')
	
	var random = RandomNumberGenerator.new()
#	var interactive = load('./Scenes/InteractiveCube.tscn')
	for i in 10:
		var cube = cubeScene.instantiate()
		random.randomize()
		var yChange = random.randf_range(0, 1)
		var xChange = random.randf_range(-10, 10)
		var zChange = random.randf_range(-10, 10)
		cube.translate(Vector3(xChange, yChange, zChange))
		cube.scale = Vector3(1, 2+yChange, 1)
		add_child(cube)
#	Map change
#   Floor Generation
	var floorDim = Vector2(60, 60)
	for z in floorDim.y:
		for x in floorDim.x:
			var cube = mudTile.instantiate()
			random.randomize()
			var yChange = 0
#			var yChange = random.randf_range(-0.05, 0.05)
			var tileMesh = cube.get_node(("MeshInstance3D"))
			var currentMesh = tileMesh.get_transform()
			cube.translate(Vector3( x-(floorDim.x/2), -1, z-(floorDim.y/2) ))
			cube.scale = Vector3(1, 1+yChange, 1)
			add_child(cube)


#	for i in 2:
#		var gun = gunScene.instantiate()
#		gun.translate(Vector3(0, 2, (i-5)*5))
#		gun.set_rotation(Vector3(0, PI/2, 0))
#		add_child(gun)
