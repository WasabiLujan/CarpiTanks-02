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
	
	#Rotacion del sprite
	
	if movimiento.length() > 0.1 and $Sprite:
		# Calcula el ángulo hacia donde se mueve
		var angulo = movimiento.angle() + PI/2 # Ajustá el offset si tu sprite mira hacia arriba 
		
		$Sprite.rotation = angulo
		
	move_and_slide(movimiento)

func _on_Area2D_body_entered(body): #Con este puede perseguir al tanque del jugador, falta ajustar direccion del sprite
	if body != self:
		jugador = body


func _on_Area2D_body_exited(body):
	jugador = null

