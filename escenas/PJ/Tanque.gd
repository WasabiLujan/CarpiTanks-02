extends KinematicBody2D

var velocidad = 200
var movimiento = Vector2()
#var ultipo_movimiento = #Para cargar en él el ultimo movimiento que se realizó, y usarlo para que el

func _physics_process(delta):
	
	movimiento = Vector2()
	movimiento()


func movimiento():
	if Input.is_action_pressed("ui_up"):
		movimiento.y = -velocidad
		rotation_degrees = 270
	if Input.is_action_pressed("ui_down"):
		movimiento.y = velocidad
		rotation_degrees = 90
	if Input.is_action_pressed("ui_right"):
		movimiento.x = velocidad
		rotation_degrees = 0
	if Input.is_action_pressed("ui_left"):
		movimiento.x = -velocidad
		rotation_degrees = 180
	if Input.is_action_pressed("shoot"):
		velocidad = 1000 * movimiento
	
	movimiento = movimiento.normalized()
	
	movimiento = move_and_slide(movimiento * velocidad)
	#ultipo_movimiento = movimiento()


#Ver de sumar un nitro de vez en cuando para hacerlo más dinamico
func nitro():
	if Input.is_action_pressed("shoot"):
		velocidad = 1000
