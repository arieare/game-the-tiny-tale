extends Node

"""
Easy set up for 3D pixelart viewport, camera, and environment properties
Load this as autoload under alias of "world"
"""

@export var game_root_node: Node
@export  var is_style_enabled = true
var pixel_art_post_processor = preload("res://content/material/pixel_outline.tres")
var dither_post_processor = preload("res://content/material/dither.tres")
	
var parent: Camera3D
var pixel_size = 1
func assert_parent(parent_node: Camera3D):
	parent = parent_node

func _ready() -> void:
	parent = get_parent()
	init_pixelart_outline(pixel_art_post_processor)
	init_pixelart_style(game_root_node, pixel_size)

func init_pixelart_outline(pixel_outline_material:Resource):
	## Mesh Renderer
	if is_style_enabled:
		var pixel_outline_renderer = MeshInstance3D.new()
		var plane_mesh = QuadMesh.new()
		plane_mesh.resource_name = "Plane"
		plane_mesh.size = Vector2(2,2)
		plane_mesh.flip_faces = true
		pixel_outline_renderer.mesh = plane_mesh
		pixel_outline_renderer.extra_cull_margin = 16300 # Extra big number
		#pixel_outline_renderer.set_surface_override_material(0,dither_post_processor)
		pixel_outline_renderer.material_overlay = pixel_art_post_processor
		pixel_outline_renderer.name = "pixel_renderer"
		parent.add_child.call_deferred(pixel_outline_renderer)

func init_pixelart_style(_root:Node, _pixel_size:int):
	## Add Subviewport setting only if PixelArt display is enabled
	if is_style_enabled:
		var pixel_viewport = SubViewportContainer.new()
		pixel_viewport.name = "pixel_viewport"
		pixel_viewport.stretch = true
		pixel_viewport.stretch_shrink = _pixel_size
		pixel_viewport.layout_direction = Control.LAYOUT_DIRECTION_LOCALE
		pixel_viewport.size = DisplayServer.window_get_size()
		pixel_viewport.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		pixel_viewport.anchors_preset = Control.PRESET_FULL_RECT
		pixel_viewport.size_flags_horizontal = Control.SIZE_FILL
		pixel_viewport.size_flags_vertical = Control.SIZE_FILL
		pixel_viewport.material = dither_post_processor
		_root.add_child.call_deferred(pixel_viewport)
		
		var pixel_subviewport = SubViewport.new()
		pixel_subviewport.name = "pixel_sub_viewport"
		pixel_subviewport.handle_input_locally = false
		pixel_subviewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
		pixel_viewport.add_child.call_deferred(pixel_subviewport)
		
		# Reparent to pixel filter
		for child in _root.get_children():
			if child is SubViewportContainer:
				pass
			else: child.reparent.call_deferred(pixel_subviewport)
