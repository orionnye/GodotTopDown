extends RigidBody

#Player Movement
export var speed = 0.1
export var maxSpeed = 1
var decay = 0.1
var velocity = Vector3(0, 0, 0)

#Global tools
onready var this = $"."
onready var map = $"../."
onready var cam = $"Camera"
onready var shotgun = $"./Shotgun"

# ----------------- Gun Functions -------------------------
func handleGun(gun):
	if gun.automatic:
		if Input.is_action_pressed("shoot"):
			gun.fire()
			velocity += gun.get_recoil()
	else:
		if Input.is_action_just_pressed("shoot"):
			gun.fire()
			velocity += gun.get_recoil()

#---------------------- Exit -----------------------
func _ready():
	pass
func _process(delta):
	handleGun(shotgun)
