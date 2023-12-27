import { PlayerControls } from "./playerControls.js"

export interface PlayerControlsDataSource {
    playerControlsQuaternionForObject(
        controls: PlayerControls,
        objectName: string
    ): any;

    playerControlsCanMoveForwardObject(
        controls: PlayerControls,
        objectName: string
    ): any;

    playerControlsCanMoveBackwardObject(
        controls: PlayerControls,
        objectName: string
    ): any;    

    playerControlsCanMoveLeftObject(
        controls: PlayerControls,
        objectName: string
    ): any;   
    
    playerControlsCanMoveRightObject(
        controls: PlayerControls,
        objectName: string
    ): any;   
}