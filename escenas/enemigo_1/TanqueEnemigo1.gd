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


<<<<<<< Updated upstream
func _on_Area2D_body_entered(body): #Con este puede perseguir al tanque del jugador, falta ajustar direccion del sprite
	if body != self:
		jugador = body
=======
func _on_Area2D_body_entered(body): #Con esta area detecta al enemigo para acercarse a él
	if body != self:
		jugador = body
	
>>>>>>> Stashed changes


func _on_Area2D_body_exited(body):
	jugador = null
<<<<<<< Updated upstream

=======
	
>>>>>>> Stashed changes
