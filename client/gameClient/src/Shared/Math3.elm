module Shared.Math3 exposing (..)

import Shared.Vector3 exposing (Vector3)
import Shared.SceneObject exposing (SceneObject)
import Math.Matrix4
import Math.Vector3

translate : Float -> Float -> Float -> SceneObject -> Vector3
translate x y z sceneObject =
    let position = sceneObject.position in
    let rotation = sceneObject.rotation in
    let matrix = Math.Matrix4.identity in
    let translatedMatrix = Math.Matrix4.translate3 position.x position.y position.z matrix  in
    let rotatedMatrixX = Math.Matrix4.rotate rotation.x (Math.Vector3.vec3 1.0  0.0 0.0) translatedMatrix in
    let rotatedMatrixY = Math.Matrix4.rotate rotation.y (Math.Vector3.vec3 0.0  1.0 0.0) rotatedMatrixX in
    let rotatedMatrixZ = Math.Matrix4.rotate rotation.z (Math.Vector3.vec3 0.0  0.0 1.0) rotatedMatrixY in
    let translatedMatrix2 = Math.Matrix4.translate3 x y z rotatedMatrixZ  in
    let newPosition = Math.Matrix4.transform translatedMatrix2 (Math.Vector3.vec3 0 0 1) in
        {
            x = Math.Vector3.getX newPosition,
            y = Math.Vector3.getY newPosition,
            z = Math.Vector3.getZ newPosition
        }
