extends KinematicBody2D

export var velocidad := 200
var vel_vec := Vector2.ZERO
#const proyectil_objeto = preload("res://escenas/PJ/Projectile.tscn")

#varibles para el nitro 
export var nitro_multiplier := 2.0        # multiplica la velocidad
export var nitro_duracion := 1.5          # segundos que dura el nitro
export var nitro_cooldown := 3.0          # segundos hasta que se pueda usar otra vez
var nitro_activo := false
var nitro_tiempo_restante := 0.0
var nitro_cooldown_restante := 0.0

#func _process(delta):
#	if Input.is_action_just_pressed("shoot"):
#		var proyectil = proyectil_objeto.instance()
#		proyectil.global_position = global_position
#		get_parent().add_child(proyectil)

func _physics_process(delta):
	# Actualiza timer del nitro
	_actualizar_nitro_timers(delta)

	# Input y movimiento
	vel_vec = Vector2.ZERO
	_manejar_input()

	if vel_vec != Vector2.ZERO:
		# Normaliza y aplica velocidad
		var velocidad_actual = velocidad
		if nitro_activo:
			velocidad_actual *= nitro_multiplier
		vel_vec = vel_vec.normalized() * velocidad_actual

		_actualizar_animacion_por_direccion(vel_vec)
	else:
		if $AnimationPlayer:
			$AnimationPlayer.stop()

	move_and_slide(vel_vec)

func _manejar_input():
	if Input.is_action_pressed("ui_up"):
		vel_vec.y -= 1
	if Input.is_action_pressed("ui_down"):
		vel_vec.y += 1
	if Input.is_action_pressed("ui_right"):
		vel_vec.x += 1
	if Input.is_action_pressed("ui_left"):
		vel_vec.x -= 1

	
	if Input.is_action_pressed("nitro"):
		_try_activate_nitro()
		
		
func _try_activate_nitro():
	# Solo activar si no está activo y no está en cooldown
	if not nitro_activo and nitro_cooldown_restante <= 0.0:
		nitro_activo = true
		nitro_tiempo_restante = nitro_duracion

func _actualizar_nitro_timers(delta):
	if nitro_activo:
		nitro_tiempo_restante -= delta
		if nitro_tiempo_restante <= 0.0:
			nitro_activo = false
			nitro_cooldown_restante = nitro_cooldown
			
	elif nitro_cooldown_restante > 0.0:
		nitro_cooldown_restante -= delta
		if nitro_cooldown_restante < 0.0:
			nitro_cooldown_restante = 0.0


#Función para mover el Pj
func _actualizar_animacion_por_direccion(vel: Vector2):
	var x = vel.x
	var y = vel.y

	#Código para moverse en diagonal
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
			



