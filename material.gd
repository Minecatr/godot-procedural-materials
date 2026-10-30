class_name MaterialType
extends Resource

@export var power:int=0
@export var weight:float=1
@export var strength:int=0
@export var fuel:int=0
@export var allowed_processes:Array[String]=[]
@export var effects:Dictionary[String,float]={}
@export var material:Material=StandardMaterial3D.new()
@export var raw_material:Material
