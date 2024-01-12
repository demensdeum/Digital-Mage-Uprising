import os
import bpy

class SceneFormat:
    def __init__(self, name, version):
        self.name = name
        self.version = version

class Scene:
    def __init__(self, name, skybox, physics_enabled = True):
        self.name = name
        self.format = SceneFormat("DemensDeum Digital Mage Uprising Scene File", "1.0.0.0")
        self.physics_enabled = physics_enabled
        self.skybox = skybox
        self.objects = []

name = "Hi-Tech Town"
skybox = "com.demensdeum.blue.field"
scene_filename = "com.demensdeum.hitech.town"        
physics_enabled = True

directory = os.path.dirname(os.path.dirname(bpy.data.filepath))

scene_file_suffix = "scene"
scene_file_extension = "json"

scene_filepath = f"{directory}\\{scene_filename}.{scene_file_suffix}.{scene_file_extension}"

print(f"directory: {directory}")
print(f"scene_filepath: {scene_filepath}")

scene = Scene(name, skybox, physics_enabled)


blender_scene = bpy.context.scene

debugC = blender_scene.collection
print(f"debugC: {debugC}")

blender_scene_objects_collection = next(c for c in blender_scene.collection.children if c.name == "SceneObjects")

scene_file = open(scene_filepath, "w")

for node in blender_scene_objects_collection.all_objects:
    print(node.name)
    print(node.location)
    print(node.rotation_euler)

print(scene_filepath)
print(blender_scene_objects_collection.name)

scene_file.close()