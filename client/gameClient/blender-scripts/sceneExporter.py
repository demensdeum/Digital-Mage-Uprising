import bpy

name = "Hi-Tech Town"
skybox = "com.demensdeum.blue.field"
scene_name = "com.demensdeum.hitech.town"

scene_file_suffix = "scene"
scene_file_extension = "json"

scene_filename = f"{scene_name}.{scene_file_suffix}.{scene_file_extension}"

scene_file = open(scene_filename, "w")

scene = bpy.context.scene
collection = scene.collection

print(scene_filename)
print(collection)

scene_file.close()