import { SceneObjectCommand } from "./sceneObjectCommand.js";
import { int } from "./types.js";
import { Vector3 } from "./vector3.js";
import { SceneObjectCommandIdle } from "./sceneObjectCommandIdle.js"
import { SceneObjectCommandTranslate } from "./sceneObjectCommandTranslate.js"
import { SceneObjectCommandJump } from "./sceneObjectCommandJump.js"
import { SceneObjectCommandRotate } from "./sceneObjectCommandRotate.js";

export class SceneObjectCommandsFactory {

    static idle(time: int): SceneObjectCommand {
        return new SceneObjectCommandIdle(
            time
        )
    }

    static moveForward(time: int): SceneObjectCommand {
        return new SceneObjectCommandTranslate(
            time,
            new Vector3(0, 0, -0.05)
        )
    }

    static moveBackward(time: int): SceneObjectCommand {
        return new SceneObjectCommandTranslate(
            time,
            new Vector3(0, 0, 0.05)
        )
    }    

    static moveLeft(time: int): SceneObjectCommand {
        return new SceneObjectCommandTranslate(
            time,
            new Vector3(-0.1, 0.0, 0)
        )
    }

    static moveRight(time: int): SceneObjectCommand {
        return new SceneObjectCommandTranslate(
            time,
            new Vector3(0.1, 0.0, 0)
        )
    }

    static jump(time: int): SceneObjectCommand {
        return new SceneObjectCommandJump(
            time
        )
    }

    static rotateLeft(time: int): SceneObjectCommand {
        return new SceneObjectCommandRotate(
            time,
            new Vector3(0.0, 0.01, 0.0)
        )
    }

    static rotateRight(time: int): SceneObjectCommand {
        return new SceneObjectCommandRotate(
            time,
            new Vector3(0.0, -0.01, 0.0)
        )
    }
}