extends KinematicBody2D

var movimiento = Vector2.ZERO

var velocidad = 300
var angulo = 0

func _ready():
	angulo = get_angle_to(get_global_mouse_position())
	
	movimiento.x = cos(angulo)
	movimiento.y = sin(angulo)

func _physics_process(delta):
	
	movimiento = movimiento.normalized() * velocidad
	
	movimiento = move_and_slide(movimiento)
	#aca quede

func _on_Timer_timeout():
	self.queue_free()


func _on_zona_colicion_body_entered(body):
	self.queue_free()
