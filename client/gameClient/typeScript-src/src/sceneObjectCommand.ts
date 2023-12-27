import { int } from "./types"
import { SceneObjectCommandType } from "./sceneObjectCommandType"

export class SceneObjectCommand {
    type: SceneObjectCommandType
    time: int

    constructor(
        type: SceneObjectCommandType,
        time: int
    )
    {
        this.type = type;
        this.time = time;
    }

    public step() {
        this.time -= 1;
    }

    public isExpired() {
        return this.time < 1;
    }
}