extends KinematicBody2D

#Llamar escena del PJ

var motion = Vector2.ZERO

var velocity = 300
var angle = 0

func _ready():
	angle = get_angle_to(get_global_mouse_position()) #"posicion _a_la_que_apunta_el_enemigo"
	 
	motion.x = cos(angle)
	motion.y = sin(angle)

func _physics_process(delta):
	motion = motion.normalized() * velocity
	
	motion = move_and_slide(motion)

func _on_Area2D_body_entered(body):
	self.queue_free()
