import os
import bpy
import json
from json import JSONEncoder

class SceneObjectModel:
    
    @staticmethod
    def default():
        return SceneObjectModel("NONE")
    
    def __init__(self,name):
        self.name = name

class SceneObjectTexture:
    
    @staticmethod
    def default():
        return SceneObjectModel("NONE")
        
    def __init__(self,name):
        self.name = name

class Vector3:
    
    @staticmethod
    def default():
        return Vector3(0,0,0)
    
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z

class SceneObject:
    
    @staticmethod
    def fromNode(node):
        print(node.name)
        print(node.location)
        print(node.rotation_euler)
        
        name = node.name
        
        type = "Model"
        model_name = "None"
        
        if name.startswith("Model_"):
            components = name.split("_")
            type = components[0]
            name = components[1]
            model_name = components[2]
        
        if name == "Camera":
            type = "Camera"
        elif name == "PlayerStartPosition":
            type = "Entity"
        
        texture = SceneObjectTexture("NONE")
        model = SceneObjectModel(model_name)
        position = Vector3(
            node.location.x,
            node.location.y,
            node.location.z
        )
        rotation = Vector3(
            node.rotation_euler.x,
            node.rotation_euler.y,
            node.rotation_euler.z
        )
        is_movable = True
        
        sceneObject = SceneObject(name, type, texture, model, position, rotation, is_movable)
    
        return sceneObject
    
    def __init__(self, name, type, texture, model, position, rotation, is_movable):
        self.name = name
        self.type = type
        self.texture = texture
        self.model = model
        self.position = position
        self.rotation = rotation
        self.isMovable = is_movable

class SceneFormat:
    def __init__(self, name, version):
        self.name = name
        self.version = version

class Scene:
    def __init__(self, name, skybox_texture_name, physics_enabled = True):
        self.name = name
        self.format = SceneFormat("DemensDeum Digital Mage Uprising Scene File", "1.0.0.0")
        self.physics_enabled = physics_enabled
        self.objects = dict()
        skyboxSceneObject = SceneObject(
            "Skybox",
            "Skybox",
            SceneObjectTexture(skybox_texture_name),
            SceneObjectModel("NONE"),
            Vector3(0, 0, 0),
            Vector3(0, 0, 0),
            False
        )
        self.objects["Skybox"] = skyboxSceneObject
        
    def addSceneObject(self, sceneObject):
        self.objects[sceneObject.name] = sceneObject

class SceneEncoder(JSONEncoder):
        def default(self, o):
            return o.__dict__

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
    
    scene.addSceneObject(SceneObject.fromNode(node))

scene_file.write(json.dumps(scene, indent = 4, cls = SceneEncoder))

print(scene_filepath)
print(blender_scene_objects_collection.name)

scene_file.close()