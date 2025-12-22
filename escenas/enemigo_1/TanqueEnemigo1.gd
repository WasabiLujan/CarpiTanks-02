extends KinematicBody2D

const proyectil_enemigo = preload("res://escenas/enemigo_1/proyectil_enemigo.tscn")

var jugador = null

var movimiento = Vector2.ZERO
var velocidad = 80

var vidas_del_enemigo1 = 2

var seguir_jugador = false
var comenzar_a_disparar = false
var detener_mov = false

export var distancia_minima := 120

func _physics_process(delta):
	""""
	if jugador == null:
		return

	var to_player = jugador.global_position - global_position
	var distancia = to_player.length()
	var direccion = to_player.normalized()

	# Animación SIEMPRE apunta al jugador
	movimiento_enemigo(direccion)

	# Movimiento SOLO si está lejos
	if distancia > distancia_minima:
		movimiento = direccion * velocidad
	else:
		movimiento = Vector2.ZERO

	move_and_slide(movimiento)
	"""
	movimiento = Vector2.ZERO
	if jugador:
		movimiento = position.direction_to(jugador.position) * velocidad #POR ACA PUEDE SER
		movimiento_enemigo(movimiento)
	movimiento = move_and_slide(movimiento)


func movimiento_enemigo(dir):
	
	if dir.length() < 0.01:
		return  # quieto, no cambiar animación

	var d = dir.normalized()
	var angle = rad2deg(d.angle())

	# Ajuste para que 0° sea "arriba"
	angle = fposmod(angle + 90, 360)

	if angle < 22.5 or angle >= 337.5:
		$AnimationPlayer.play("arriba")
	elif angle < 67.5:
		$AnimationPlayer.play("diagonal_der_arriba")
	elif angle < 112.5:
		$AnimationPlayer.play("derecha")
	elif angle < 157.5:
		$AnimationPlayer.play("diagonal_der_abajo")
	elif angle < 202.5:
		$AnimationPlayer.play("abajo")
	elif angle < 247.5:
		$AnimationPlayer.play("diagonal_izq_abajo")
	elif angle < 292.5:
		$AnimationPlayer.play("izquierda")
	else:
		$AnimationPlayer.play("diagonal_izq_arriba")
	

func recibir_dano():
	vidas_del_enemigo1 -= 1
	print("Vidas restantes DEL ENEMIGO: ", vidas_del_enemigo1)
	if vidas_del_enemigo1 <= 0:
		vidas_del_enemigo1 = 3
		get_tree().call_group("Nivel", "enemigo_muerto")
		queue_free()


func _on_Area2D_body_entered(body): #Con este puede perseguir al tanque del jugador, falta ajustar direccion del sprite
	if body.is_in_group("Jugador"):
		jugador = body

func _on_Area2D_body_exited(body):
	jugador = null



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



func _on_tiempo_prev_al_disparo_timeout():
	if jugador != null: #De esta forma refornzamos que solo suceda si hay un jugador
		disparar()

func disparar():
	if jugador == null:
		return
	
	var proyectil = proyectil_enemigo.instance()
	
	var direccion = (jugador.global_position - global_position).normalized()	 
	
	proyectil.global_position = $Sprite/PosicionDelDisparo.global_position
	proyectil.rotation = direccion.angle() + PI/2
	
	if proyectil.has_method("iniciar"):
		proyectil.iniciar(direccion)
	
	get_parent().add_child(proyectil)


func _on_Area_de_detenerce_body_entered(body):
	if body.is_in_group("Jugador"):
		jugador = body


func _on_Area_de_detenerce_body_exited(body):
	if body.is_in_group("Jugador"):
		detener_mov = false


