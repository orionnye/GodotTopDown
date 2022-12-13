extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player = get_node("res://Scenes/Prefabs/PlayerScene")
onready var this = $"."
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var plPos = get_parent().get_node("Player").global_transform.origin
	var selfPosition = global_transform.origin
	var distance = plPos.distance_to(selfPosition)
	if(distance < 3):
#		print("Interact with cube...")
		if Input.is_action_just_pressed("ui_interact"):
			print("You interacted with the Cube!")
		
