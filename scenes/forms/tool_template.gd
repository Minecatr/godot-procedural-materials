extends RigidBody3D

var head_material: String = ''
var rod_material: String = ''
var form: String = 'tool'

var work:float = 0.0
var mine:float = 0.0
var cut:float = 0.0
var dig:float = 0.0
var damage:float = 0.0
var attack_speed:float = 0.0
var reach:float = 0.0
var sweep:float = 0.0

@onready var mesh = $MeshInstance3D
@onready var collision = $CollisionShape3D
@onready var head = $Head

func _ready() -> void:
	mesh.mesh.height = reach/2
	collision.shape.height = reach/2
	head.position = reach/4
