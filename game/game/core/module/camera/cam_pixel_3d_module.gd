extends Node
'''
to be put as a child of Camera3D only
'''

@onready var parent_cam: Camera3D = get_parent()

@export  var is_style_enabled = true
var pixel_outline_filter = preload("res://content/material/pixel_outline.tres")
var dither_filter = preload("res://content/material/dither.tres")
var pixel_size = 1

func _ready() -> void:
	init_pixelart_outline(pixel_outline_filter)
	init_pixelart_style(parent_cam.get_parent().scene_root, pixel_size, dither_filter)

func init_pixelart_outline(_material:Resource):
	## Mesh Renderer
	if is_style_enabled:
		var plane_mesh = QuadMesh.new()
		plane_mesh.resource_name = "Plane"
		plane_mesh.size = Vector2(2,2)
		plane_mesh.flip_faces = true
		var pixel_outline_renderer = MeshInstance3D.new()
		pixel_outline_renderer.name = "pixel_renderer"
		pixel_outline_renderer.mesh = plane_mesh
		pixel_outline_renderer.extra_cull_margin = 16300 # Extra big number
		pixel_outline_renderer.material_overlay = _material
		parent_cam.add_child.call_deferred(pixel_outline_renderer)

func init_pixelart_style(_root:Node, _pixel_size:int, _material:Resource):
	## Add Subviewport setting only if PixelArt display is enabled
	if is_style_enabled:
		var pixel_viewport = SubViewportContainer.new()
		pixel_viewport.name = "pixel_viewport"
		pixel_viewport.stretch = true
		pixel_viewport.stretch_shrink = _pixel_size
		pixel_viewport.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		pixel_viewport.anchors_preset = Control.PRESET_FULL_RECT
		pixel_viewport.layout_direction = Control.LAYOUT_DIRECTION_LOCALE
		pixel_viewport.size = DisplayServer.window_get_size()
		pixel_viewport.size_flags_horizontal = Control.SIZE_FILL
		pixel_viewport.size_flags_vertical = Control.SIZE_FILL
		pixel_viewport.material = _material
		_root.add_child.call_deferred(pixel_viewport)
		
		var pixel_subviewport = SubViewport.new()
		pixel_subviewport.name = "pixel_sub_viewport"
		pixel_subviewport.handle_input_locally = false
		pixel_subviewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
		pixel_viewport.add_child.call_deferred(pixel_subviewport)
		
		# Reparent to pixel filter
		for child in _root.get_children():
			if child is not SubViewportContainer:
				child.reparent.call_deferred(pixel_subviewport)
