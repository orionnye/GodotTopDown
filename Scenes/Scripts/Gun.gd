extends Spatial
#Bullet Data
var bulletList = []
export var bulletSpeed = 100.0
export var bulletDistance = 1000
export var decay = 0.9
export var bulletPerShot = 1
export var bulletMass = 1
export var spread = PI/4
export var reloadTime = 1.0
var reloading = 0
export var bulletTimeAlive = 2.0
export var automatic = true
var bulletScene = load('res://Scenes/Prefabs/Bullet.tscn')

onready var map = $"../.."

func get_rotation() -> Vector3:
	var this = $"."
	var globalRotation = this.global_transform.basis.get_euler()
	var rotation = Vector3.FORWARD.rotated(Vector3.UP, globalRotation.y)
	rotation.rotated(Vector3.LEFT, globalRotation.x)
	rotation.rotated(Vector3.BACK, globalRotation.z)
	return rotation.normalized()
func get_recoil() -> Vector3:
	var bulletForce = bulletSpeed*bulletMass
	var fireForce = get_rotation() * bulletForce*bulletPerShot
	return -fireForce
func _process(delta):
	if reloading > 0:
		reloading -= delta
func fire():
	if reloading <= 0:
		for i in bulletPerShot:
			var random = RandomNumberGenerator.new()
			random.randomize()
			var direction = randf()*spread - spread/2
			fire_bullet(bulletSpeed, direction)
		reloading = reloadTime

func fire_bullet(speed, direction):
#	direction is measured in radians from straight forward of gun(ie: -PI/6, PI/8)
	var this = $"."
	var bullet = bulletScene.instance()
	var globalRotation = this.global_transform.basis.get_euler()
	
	var bulletForce = (get_rotation()*bulletSpeed).rotated(Vector3.UP, direction)
	bullet.transform.origin = this.get_global_transform().origin
	bullet.apply_central_impulse(bulletForce)
	map.add_child(bullet)
