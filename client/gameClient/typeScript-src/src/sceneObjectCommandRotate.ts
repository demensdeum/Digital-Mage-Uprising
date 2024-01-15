import { SceneObjectCommand } from "./sceneObjectCommand.js";
import { Vector3 } from "./vector3.js";

export class SceneObjectCommandRotate extends SceneObjectCommand {

    rotate: Vector3

    constructor(
        time: number,
        rotate: Vector3
    ) {
        super(time)
        this.rotate = rotate
    }

}