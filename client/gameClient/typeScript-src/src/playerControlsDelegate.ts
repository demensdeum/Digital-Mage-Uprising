import { PlayerControls } from "./playerControls.js"
import { float } from "./types.js"

export interface PlayerControlsDelegate {
    playerControlsRequireObjectTranslate(
        controls: PlayerControls,
        objectName: string,
        x: float,
        y: float,
        z: float
    ): void;

    playerControlsRequireObjectRotation(
        controls: PlayerControls,
        objectName: string,
        euler: any
    ): void;

    playerControlsRequireJump(
        controls: PlayerControls,
        objectName: string
    ): void;
}