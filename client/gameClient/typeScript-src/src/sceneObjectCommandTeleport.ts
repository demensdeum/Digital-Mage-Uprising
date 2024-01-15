import { SceneObjectCommand } from "./sceneObjectCommand.js";
import { Vector3 } from "./vector3";

export class SceneObjectCommandTeleport extends SceneObjectCommand {
    
    position: Vector3

    constructor(
        time: number,
        position: Vector3
    ) {
        super(time)
        this.position = position
    }

}