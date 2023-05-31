extends AnimationPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@onready var anim = $"."

# Called when the node enters the scene tree for the first time.
#func _ready():
#	anim.play("ArmatureAction")
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func run():
	anim.play("Run")
func jump():
	anim.play("Jump")
func roll():
	anim.play("Roll")
#	pass
