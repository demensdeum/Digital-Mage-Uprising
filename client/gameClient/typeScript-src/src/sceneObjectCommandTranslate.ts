import { SceneObjectCommand } from "./sceneObjectCommand.js";
import { Vector3 } from "./vector3.js";

export class SceneObjectCommandTranslate extends SceneObjectCommand {

    translate: Vector3

    constructor(
        time: number,
        translate: Vector3
    ) {
        super(time)
        this.translate = translate
    }

}