import { SceneObjectCommand } from "./sceneObjectCommand.js";
import { int } from "./types.js";
import { Vector3 } from "./vector3.js";
import { SceneObjectCommandIdle } from "./sceneObjectCommandIdle.js"
import { SceneObjectCommandTranslate } from "./sceneObjectCommandTranslate.js"
import { SceneObjectCommandJump } from "./sceneObjectCommandJump.js"
import { SceneObjectCommandRotate } from "./sceneObjectCommandRotate.js";

export class SceneObjectCommandsFactory {

    static idle(
        name: String,
        time: int
    ): SceneObjectCommand {
        return new SceneObjectCommandIdle(
            name,
            time
        )
    }

    static moveForward(
        name: String,
        time: int
    ): SceneObjectCommand {
        return new SceneObjectCommandTranslate(
            name,
            time,
            new Vector3(0, 0, -0.05)
        )
    }

    static moveBackward(
        name: String,
        time: int
    ): SceneObjectCommand {
        return new SceneObjectCommandTranslate(
            name,
            time,
            new Vector3(0, 0, 0.05)
        )
    }    

    static moveLeft(
        name: String,
        time: int
    ): SceneObjectCommand {
        return new SceneObjectCommandTranslate(
            name,
            time,
            new Vector3(-0.1, 0.0, 0)
        )
    }

    static moveRight(
        name: String,
        time: int
    ): SceneObjectCommand {
        return new SceneObjectCommandTranslate(
            name,
            time,
            new Vector3(0.1, 0.0, 0)
        )
    }

    static jump(
        name: String,
        time: int
    ): SceneObjectCommand {
        return new SceneObjectCommandJump(
            name,
            time
        )
    }

    static rotateLeft(
        name: String,
        time: int
    ): SceneObjectCommand {
        return new SceneObjectCommandRotate(
            name,
            time,
            new Vector3(0.0, 0.01, 0.0)
        )
    }

    static rotateRight(
        name: String,
        time: int
    ): SceneObjectCommand {
        return new SceneObjectCommandRotate(
            name,
            time,
            new Vector3(0.0, -0.01, 0.0)
        )
    }
}