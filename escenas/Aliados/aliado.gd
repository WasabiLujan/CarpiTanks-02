extends KinematicBody2D

var motion = Vector2.ZERO
var velocity = 100

var jugador_cerca = false
var jugador = null
var detenerse = false

func _physics_process(delta):
	motion = Vector2.ZERO
	
	if jugador_cerca == true and detenerse == false:
		motion = position.direction_to(jugador.position)
		movimiento_aliado()
	
	motion = motion.normalized() * velocity
	move_and_slide(motion)
	

func movimiento_aliado():
	var x = motion.x
	var y = motion.y

	if x > 0.3 and y < -0.3:
		$AnimationPlayer.play("diagonal_der_arriba")
	elif x > 0.3 and y > 0.3:
		$AnimationPlayer.play("diagonal_der_abajo")
	elif x < -0.3 and y < -0.3:
		$AnimationPlayer.play("diagonal_izq_arriba")
	elif x < -0.3 and y > 0.3:
		$AnimationPlayer.play("diagonal_izq_abajo")
	elif abs(x) > abs(y):
		if x > 0:
			$AnimationPlayer.play("derecha")
		else:
			$AnimationPlayer.play("izquierda")
	else:
		if y < 0:
			$AnimationPlayer.play("arriba")
		else:
			$AnimationPlayer.play("abajo")


func _on_AreaDeActivacion_body_entered(body):
	if body.is_in_group("Jugador"):
		jugador = body
		jugador_cerca = true		


func _on_AreaParaDetenerce_body_entered(body):
	if body.is_in_group("Jugador"):
		detenerse = true
		jugador = body
		motion = Vector2.ZERO

func _on_AreaParaDetenerce_body_exited(body):
	if body.is_in_group("Jugador"):
		detenerse = false
