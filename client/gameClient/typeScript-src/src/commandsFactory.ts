import { SceneObjectCommand } from "./sceneObjectCommand.js";
import { SceneObjectCommandType } from "./sceneObjectCommandType.js";
import { int } from "./types.js";

export class CommandsFactory {

    static idle(time: int): SceneObjectCommand {
        return new SceneObjectCommand(
            SceneObjectCommandType.idle,
            time
        )
    }

    static moveForward(time: int): SceneObjectCommand {
        return new SceneObjectCommand(
            SceneObjectCommandType.moveForward,
            time
        )
    }

    static moveLeft(time: int): SceneObjectCommand {
        return new SceneObjectCommand(
            SceneObjectCommandType.moveLeft,
            time
        )
    }

    static moveRight(time: int): SceneObjectCommand {
        return new SceneObjectCommand(
            SceneObjectCommandType.moveRight,
            time
        )
    }

    static jump(time: int): SceneObjectCommand {
        return new SceneObjectCommand(
            SceneObjectCommandType.jump,
            time
        )
    }
}