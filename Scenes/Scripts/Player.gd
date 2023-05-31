extends RigidBody3D

#Player Movement
@export var speed = 0.1
@export var maxSpeed = 1
@export var jumpTime = 0.5
@export var jumpForce = 80
@export var groundDamp = 7
@export var airDamp = 3
var jumping = false
#var velocity = Vector3(0, 0, 0)

#Global tools
@onready var this = $"."
@onready var map = $"../."
@onready var cam = $"Camera3D"
@onready var shotgun = $"./Shotgun"

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
