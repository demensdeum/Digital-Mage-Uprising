import { PhysicsControllerCollision } from "./physicsControllerCollision"
import { PhysicsController } from "./physicsController"
import { SimplePhysicsControllerBody } from "./simplePhysicsControllerBody";
import { Vector3 } from "./vector3";

export interface PhysicsControllerDelegate {
    physicsControllerDidDetectDistance(
        physicsController: PhysicsController,
        collision: PhysicsControllerCollision
    ): void;
    physicControllerRequireApplyPosition(
        objectName: string,
        physicsController: PhysicsController,
        position: Vector3
    ): void;
}