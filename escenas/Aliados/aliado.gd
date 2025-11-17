extends KinematicBody2D

var motion = Vector2.ZERO
var velocity = 150

var jugador_cerca = false
var jugador = null
var detenerse = false

#var colicionar_con_mundo = false

func _ready():
	pass

func _physics_process(delta):
	motion = Vector2.ZERO
	
	#Aca revisamos si la exitencia del jugador existe pero fue eliminada, en el caso del Game Over
	if jugador and not is_instance_valid(jugador):#Investigar sobre el "is_intance_valid"
		jugador = null
		jugador_cerca = false
	
	#Aca seguimos al jugador, con varias condiciones para que no de un bug
	if jugador and is_instance_valid(jugador) and not detenerse:
		#Almacenamos en una variable la accion de seguir al jugador
		var dire = position.direction_to(jugador.position)
		#Aca usamos los Ray para detectar si choca algo y corregir la direccion
		# Cuando coliciona arriba
		if dire.y < -0.4 and $RayCastUp.is_colliding():
			dire.y = 0 #Deja de seguir intentando ir hacia arriba al chocar en esa dire
		#Abajo
		if dire.y > 0.4 and $RayCastDown.is_colliding():
			dire.y = 0
		#Izquierda
		if dire.x < -0.4 and $RayCastLeft.is_colliding():
			dire.x = 0
		#Derecha
		if dire.x > 0.4 and $RayCastRigth.is_colliding():
			dire.x = 0
		#Si ambos componentes quedan en 0, estamos bloqueados
		if dire != Vector2.ZERO:
			motion = dire.normalized() * velocity
		# Diagonales
		if dire.x > 0.4 and dire.y < -0.4 and $RayCastUpRight.is_colliding():
			dire.x = 0
			dire.y = 0
		
		if dire.x > 0.4 and dire.y > 0.4 and $RayCastDownRight.is_colliding():
			dire.x = 0
			dire.y = 0
		
		if dire.x < -0.4 and dire.y < -0.4 and $RayCastUpLeft.is_colliding():
			dire.x = 0
			dire.y = 0
		
		if dire.x < -0.4 and dire.y > 0.4 and $RayCastDownLeft.is_colliding():
			dire.x = 0
			dire.y = 0
	else:
		motion = Vector2.ZERO
	
	movimiento_aliado() #Actualizamos visual del tanque dependiendo direccion resultante
		
	move_and_slide(motion)
	
	
	"""
	if jugador_cerca and not detenerse:
		motion = position.direction_to(jugador.position)
		movimiento_aliado()

	
	motion = motion.normalized() * velocity
	move_and_slide(motion)
	"""

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
	

func _on_AreaDeActivacion_body_exited(body):
	#if body == jugador:
		#jugador_cerca = false
		#jugador = null
	pass


func _on_AreaParaDetenerce_body_entered(body):
	if body.is_in_group("Jugador"):
		jugador = body
		detenerse = true
		motion = Vector2.ZERO

func _on_AreaParaDetenerce_body_exited(body):
	if body.is_in_group("Jugador"):
		detenerse = false

