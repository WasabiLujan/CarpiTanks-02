extends KinematicBody2D


export var velocidad = 220
var direccion = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	mover()
	move_and_slide(direccion * velocidad)

func mover():
	if Input.is_action_pressed("ui_right"):
		direccion = Vector2.RIGHT
	elif Input.is_action_pressed("ui_left"):
		direccion = Vector2.LEFT
	elif Input.is_action_pressed("ui_down"):
		direccion = Vector2.DOWN
	elif Input.is_action_pressed("ui_up"):
		direccion = Vector2.UP
	if  (Input.is_action_just_released("ui_right") or 
			Input.is_action_just_released("ui_left") or 
			Input.is_action_just_released("ui_up") or 
			Input.is_action_just_released("ui_down")):
		direccion = Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


	


