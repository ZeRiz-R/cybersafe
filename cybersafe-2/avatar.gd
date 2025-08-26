extends PanelContainer

@onready var avatar_image: TextureRect = $Panel/AvatarImage
func select_image(name: String):
	var avatar_properties = Constants.Avatars.get(name, Constants.Avatars["Default"])
	avatar_image.texture = avatar_properties.get("texture")
	avatar_image.scale = avatar_properties.get("scale", Vector2(1, 1))
	avatar_image.position = avatar_properties.get("position", Vector2(0, 0))
	
