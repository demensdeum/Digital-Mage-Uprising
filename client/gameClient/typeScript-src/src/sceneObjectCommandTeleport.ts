import { SceneObjectCommand } from "./sceneObjectCommand.js";
import { Vector3 } from "./vector3";

export class SceneObjectCommandTeleport extends SceneObjectCommand {
    
    position: Vector3

    constructor(
        name: String,
        time: number,
        position: Vector3
    ) {
        super(name, time)
        this.position = position
    }

}