extends KinematicBody2D

var jugador = null

var movimiento = Vector2.ZERO
var velocidad = 100

func _physics_process(delta):
	movimiento = Vector2.ZERO
	
	if jugador != null:
		movimiento = position.direction_to(jugador.position)
	else:
		movimiento = Vector2.ZERO
	movimiento = movimiento.normalized() * velocidad
	movimiento = move_and_slide(movimiento)


func _on_Area2D_body_entered(body):
	if body != self:
		jugador = body
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	jugador = null
	pass # Replace with function body.
