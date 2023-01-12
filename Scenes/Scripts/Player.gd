extends RigidBody

#Player Movement
export var speed = 0.1
export var maxSpeed = 1
export var jumpTime = 1
export var jumpForce = 80
export var airDamp = 3
export var groundDamp = 5
var jumping = false
#var velocity = Vector3(0, 0, 0)

#Global tools
onready var this = $"."
onready var map = $"../."
onready var cam = $"Camera"
onready var shotgun = $"./Shotgun"

# ----------------- Gun Functions -------------------------
func handleGun(gun):
	if gun.automatic:
		if Input.is_action_pressed("shoot") && gun.reloading <= 0:
			gun.fire()
			this.apply_central_impulse(gun.get_recoil())
	else:
		if Input.is_action_just_pressed("shoot") && gun.reloading <= 0:
			gun.fire()
			this.apply_central_impulse(gun.get_recoil())

#---------------------- Exit -----------------------
func _ready():
	pass
func _process(delta):
	handleGun(shotgun)
