extends KinematicBody2D

const proyectil_enemigo = preload("res://escenas/enemigo_1/proyectil_enemigo.tscn")

var jugador = null

var movimiento = Vector2.ZERO
var velocidad = 80

var vidas_del_enemigo1 = 4

var seguir_jugador = false
var comenzar_a_disparar = false
var detener_mov = false

func _physics_process(delta):
	movimiento = Vector2.ZERO
	
	if jugador != null and not detener_mov:
		movimiento = position.direction_to(jugador.position)
	else:
		movimiento = Vector2.ZERO
	
	movimiento = movimiento.normalized() * velocidad
		
	movimiento_enemigo()
	movimiento = movimiento.normalized() * velocidad
	move_and_slide(movimiento)
	
	
func movimiento_enemigo():
	var x = movimiento.x
	var y = movimiento.y

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
		if y <= 0:
			$AnimationPlayer.play("arriba")
		else:
			$AnimationPlayer.play("abajo")

func recibir_dano():
	vidas_del_enemigo1 -= 1
	print("Vidas restantes DEL ENEMIGO: ", vidas_del_enemigo1)
	if vidas_del_enemigo1 <= 0:
		vidas_del_enemigo1 = 3
		get_tree().call_group("Nivel", "enemigo_muerto")
		queue_free()



func _on_Area2D_body_entered(body): #Con este puede perseguir al tanque del jugador, falta ajustar direccion del sprite
	if body.is_in_group("Jugador"):
		seguir_jugador = true
		jugador = body

func _on_Area2D_body_exited(body):
	if body.is_in_group("Jugador"):
		seguir_jugador = false
		_verificar_salida()
	#jugador = null



func _on_Area_de_comenzar_a_disparar_body_entered(body):
	if body.is_in_group("Jugador"):
		comenzar_a_disparar = true
		jugador = body
		$tiempo_prev_al_disparo.start()


func _on_Area_de_comenzar_a_disparar_body_exited(body):
	if body.is_in_group("Jugador"):
		comenzar_a_disparar = false
		jugador = null
		#Detener el disparo
		$tiempo_prev_al_disparo.stop()
		_verificar_salida()



func _on_tiempo_prev_al_disparo_timeout():
	if jugador != null: #De esta forma refornzamos que solo suceda si hay un jugador
		disparar()

func disparar():
	var proyectil = proyectil_enemigo.instance()
	var direccion_a_jugador = Vector2.ZERO
	if jugador != null:
		# Este vector (normalized) es la dirección exacta
		direccion_a_jugador = (jugador.position - global_position).normalized()
		
	var offset_dist = 50  # Distancia desde donde sale el disparo
	var offset_global = direccion_a_jugador * offset_dist
	
	#posición global del proyectil
	proyectil.position = $Sprite/PosicionDelDisparo.global_position + offset_global
	
	# 3. Configurar rotación (se basa en la dirección vectorizada)
	# La rotación del proyectil se obtiene del ángulo del vector de dirección.
	proyectil.rotation = direccion_a_jugador.angle() + PI/2
	
	# irección vectorizada al proyectil
	if proyectil.has_method("iniciar"):
		proyectil.iniciar(direccion_a_jugador) 
	
	get_parent().add_child(proyectil)



func _on_Area_de_detenerce_body_entered(body):
	if body.is_in_group("Jugador"):
		detener_mov = true
		jugador = body
		#movimiento = Vector2.ZERO

func _on_Area_de_detenerce_body_exited(body):
	if body.is_in_group("Jugador"):
		detener_mov = false
		_verificar_salida()


func _verificar_salida():
	if not detener_mov and not seguir_jugador and not comenzar_a_disparar:
		jugador = null
