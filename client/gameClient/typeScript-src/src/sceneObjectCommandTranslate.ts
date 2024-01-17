import { SceneObjectCommand } from "./sceneObjectCommand.js";
import { Vector3 } from "./vector3.js";

export class SceneObjectCommandTranslate extends SceneObjectCommand {

    translate: Vector3

    constructor(
        name: String,
        time: number,
        translate: Vector3
    ) {
        super(name, time)
        this.translate = translate
    }

}