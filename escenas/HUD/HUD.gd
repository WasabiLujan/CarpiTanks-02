extends CanvasLayer

onready var Live1 = $TextureRect/V1
onready var Live2 = $TextureRect/V2
onready var Live3 = $TextureRect/V3
onready var Live4 = $TextureRect/V4
onready var Live5 = $TextureRect/V5

onready var a_save = $TextureRect/aliado_salvado

onready var enemigo1 = $TextureRect/enemigo_vivo
onready var enemigo2 = $TextureRect/enemigo_vivo2
onready var enemigo3 = $TextureRect/enemigo_vivo3
onready var enemigo4 = $TextureRect/enemigo_vivo4

# Número máximo de vidas (ajustalo si es otro)
const MAX_LIVES = 5

func _ready():
	a_save.visible = false
	# inicializar todas las vidas visibles al comienzo (o según quieras)
	actualizar_vistas_de_vidas(MAX_LIVES)

# Actualiza las vidas en base a un entero (0..MAX_LIVES)
func lives_out(vidas_del_p):
	vidas_del_p = int(clamp(vidas_del_p, 0, MAX_LIVES))
	actualizar_vistas_de_vidas(vidas_del_p)

func actualizar_vistas_de_vidas(vidas):
	Live1.visible = vidas >= 1
	Live2.visible = vidas >= 2
	Live3.visible = vidas >= 3
	Live4.visible = vidas >= 4
	Live5.visible = vidas >= 5


# Aliado
func save(aliado_rescatado):
	a_save.visible = bool(aliado_rescatado)

func no_save():
	a_save.visible = false

# Enemigos restantes (versión usando comparaciones, no booleanos raros)
func cuantos_enemigos_restan(enemigos_del_HUD):
	enemigos_del_HUD = int(max(0, enemigos_del_HUD))
	enemigo1.visible = enemigos_del_HUD >= 1
	enemigo2.visible = enemigos_del_HUD >= 2
	enemigo3.visible = enemigos_del_HUD >= 3
	enemigo4.visible = enemigos_del_HUD >= 4

