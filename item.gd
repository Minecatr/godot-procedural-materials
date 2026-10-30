class_name Item
extends Resource

var material: String
var form: String
var count: int

func _init(p_form:='orb',p_count:=1,p_material:='any') -> void:
	form = p_form
	count = p_count
	material = p_material
