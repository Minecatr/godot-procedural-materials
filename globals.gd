class_name GLOBALS
extends Resource

static var world:Node3D

static var material_types: = {
	'wood': preload("res://assets/materials/wood.tres"),
	'stone': preload("res://assets/materials/stone.tres"),
	'dirt': preload("res://assets/materials/dirt.tres"),
	'sillica': preload("res://assets/materials/sillica.tres"),
	'iron': preload("res://assets/materials/iron.tres"),
	'gold': preload("res://assets/materials/gold.tres"),
	'cactus': preload("res://assets/materials/cactus.tres"),
	'roseberry': preload("res://assets/materials/roseberry.tres"),
	'obsidian': preload("res://assets/materials/obsidian.tres"),
	'diamond': preload("res://assets/materials/diamond.tres"),
	'coal': preload("res://assets/materials/coal.tres"),
}

static var tool_types: = {
	'pickaxe': preload("res://assets/tools/pickaxe.tres"),
}

static var tool_template: = preload("res://scenes/forms/tool_template.tscn")
static var tool_head: = preload("res://scenes/forms/tool_head.tscn")
static var forms: = {
	'cube': preload("res://scenes/forms/cube.tscn"),
	'orb': preload("res://scenes/forms/orb.tscn"),
	'dust': preload("res://scenes/forms/dust.tscn"),
	'log': preload("res://scenes/forms/log.tscn"),
	'plate': preload("res://scenes/forms/plate.tscn"),
	'rod': preload("res://scenes/forms/rod.tscn"),
}

static var processes: = {
	'cutting': {
		'input': Item.new('log',1),
		'outputs': [Item.new('stick',2)], 
	},
	'grinding': {
		'input': Item.new('any',1), 
		'outputs': [Item.new('dust',1)], 
	},
	'working': {
		'input': Item.new('cube',1), 
		'outputs': [Item.new('plate',1),Item.new('pickaxe_head',1)], 
	},
}

static var recipe_sets: Dictionary = {
	#'plot': [
		#{'id': 'chest', 'ingredients': ['log','log']},
		#{'id': 'crafting_table', 'ingredients': ['log']},
		#{'id': 'furnace', 'ingredients': ['stone', 'stone']},
	#],
	#'crafting_table': [
		#{'id': 'axe', 'ingredients': ['stick', 'stone']},
		#{'id': 'hammer', 'ingredients': ['stick', 'log']},
		#{'id': 'wall', 'ingredients': ['log']},
		#{'id': 'pickaxe', 'ingredients': ['stick', 'steel']},
	#],
	#'furnace': [
		#{'id': 'coal', 'ingredients': ['log']},
		#{'id': 'steel', 'ingredients': ['coal','iron']}
	#],
}

static func _static_init() -> void:
	for type in tool_types.keys():
		var head = tool_head.instantiate()
		head.get_node('MeshInstance3D').mesh = tool_types[type].mesh
		head.get_node('CollisionShape3D').shape = tool_types[type].hitbox
		var packed_head = PackedScene.new()
		packed_head.pack(head)
		forms[type+'_head'] = packed_head
	for process in processes.keys():
		recipe_sets[process] = []
	for material_type in material_types:
		for process in material_types[material_type].allowed_processes:
			if recipe_sets.has(process):
				for output in processes[process]['outputs']:
					var m_input:Item= processes[process]['input']
					var m_output:Item= output
					m_input.material = material_type
					m_output.material = material_type
					print(process + ': '+ str(m_input.count) + 'x ' + m_input.material + '_' + m_input.form + ' -> ' + str(m_output.count) + 'x ' + m_output.material + '_' + m_output.form)
					recipe_sets[process].append({'output': m_output, 'input': m_input})
