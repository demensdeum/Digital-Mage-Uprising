import { SceneObjectCommandsFactory } from "./commandsFactory.js";
import { Controls } from "./controls";
import { ControlsDelegate } from "./controlsDelegate";
import { ControlsDataSource } from "./playerControlsDataSource.js";
import { debugPrint } from "./runtime.js";
import { SceneObjectCommand } from "./sceneObjectCommand.js";
import { SceneObjectCommandType } from "./sceneObjectCommandType.js";
import { Utils } from "./utils.js";
import { Euler } from "./euler.js";
import { SceneObjectCommandTranslate } from "./sceneObjectCommandTranslate.js";
import { SceneObjectCommandRotate } from "./sceneObjectCommandRotate.js";
import { SceneObjectCommandJump } from "./sceneObjectCommandJump.js";
import { SceneObjectCommandTeleport } from "./sceneObjectCommandTeleport.js";

//ThreeJS

export class EnemyControls implements Controls {
    public delegate: ControlsDelegate;
    public dataSource: ControlsDataSource;
    private objectName: string;

    private moveCommand: SceneObjectCommand = SceneObjectCommandsFactory.idle(0);
    private secondaryMoveCommand: SceneObjectCommand = SceneObjectCommandsFactory.idle(0);    
    private extraMoveCommand: SceneObjectCommand = SceneObjectCommandsFactory.idle(0);   
    private rotationCommand: SceneObjectCommand = SceneObjectCommandsFactory.idle(0); 
    private actionCommand: SceneObjectCommand = SceneObjectCommandsFactory.idle(0);

    constructor(
        objectName: string,
        delegate: ControlsDelegate,
        dataSource: ControlsDataSource
    ) {
        this.objectName = objectName;
        this.delegate = delegate;
        this.dataSource = dataSource
    }

    public step(delta: any): void {
        if (!this.moveCommand.isExpired()) {
            this.handleCommand(this.moveCommand);
        }
        else {
            this.moveCommand = this.comeUpWithIdeaForMoveCommand();
        }

        if (!this.secondaryMoveCommand.isExpired()) {
            this.handleCommand(this.secondaryMoveCommand);
        }
        else {
            this.secondaryMoveCommand = this.comeUpWithIdeaForSecondaryMoveCommand();
        }

        if (!this.rotationCommand.isExpired()) {
            this.handleCommand(this.rotationCommand);
        }
        else {
            this.rotationCommand = this.comeUpWithIdeaForRotationCommand();
        }

        if (!this.extraMoveCommand.isExpired()) {
            this.handleCommand(this.extraMoveCommand);
        }
        else {
            this.extraMoveCommand = this.comeUpWithIdeaForExtraMoveCommand();
        }
    }

    private comeUpWithIdeaForRotationCommand() {
        const idea = Utils.randomInt(30);
        if (idea == 9) {
            return SceneObjectCommandsFactory.rotateLeft(Utils.randomInt(1000));
        }
        else if (idea == 14) {
            return SceneObjectCommandsFactory.rotateRight(Utils.randomInt(1000));
        }
        return SceneObjectCommandsFactory.idle(Utils.randomInt(10));
    }

    private comeUpWithIdeaForMoveCommand() {
        const idea = Utils.randomInt(30);
        if (idea > 6  && idea < 20) {
            return SceneObjectCommandsFactory.moveForward(100 + Utils.randomInt(1000));
        }
        else if (idea == 4) {
            return SceneObjectCommandsFactory.moveBackward(100 + Utils.randomInt(1000));
        }        
        return SceneObjectCommandsFactory.idle(Utils.randomInt(10));
    }

    private comeUpWithIdeaForSecondaryMoveCommand() {
        const idea = Utils.randomInt(30);
        if (idea == 3) {
            return SceneObjectCommandsFactory.jump(10);
        }
        return SceneObjectCommandsFactory.idle(Utils.randomInt(10));
    }

    private comeUpWithIdeaForExtraMoveCommand() {
        const idea = Utils.randomInt(30);
        if (idea == 4) {
            return SceneObjectCommandsFactory.moveLeft(100 + Utils.randomInt(500));
        }
        else if (idea == 6) {
            return SceneObjectCommandsFactory.moveRight(100 + Utils.randomInt(500));
        }
        return SceneObjectCommandsFactory.idle(Utils.randomInt(10));
    }

    private handleCommand(command: SceneObjectCommand) {
        if (command instanceof SceneObjectCommandTranslate) {
            this.performTranslate(command);
        }
        else if (command instanceof SceneObjectCommandRotate) {
            this.performRotate(command);
        }
        else if (command instanceof SceneObjectCommandJump) {
            this.performJump(command);
        }
        else if (command instanceof SceneObjectCommandTeleport) {
            this.performTeleport(command);
        }
        command.step();   
    }

    private performTranslate(command: SceneObjectCommandTranslate) {
        // @ts-ignore
        const x = command.translate.x;
        // @ts-ignore
        const y = command.translate.y;
        // @ts-ignore
        const z = command.translate.z;
        this.delegate.controlsRequireObjectTranslate(
            this,
            this.objectName,
            x,
            y, 
            z
        );        
    }

    private performRotate(command: SceneObjectCommandRotate) {
        // @ts-ignore
        const x = command.rotate.x;
        // @ts-ignore
        const y = command.rotate.y;
        // @ts-ignore
        const z = command.rotate.z;

        const euler = new Euler(0, 0, 0, 'YXZ' );        
        const quaternion = this.dataSource.controlsQuaternionForObject(
            this,
            this.objectName
        );

        // @ts-ignore
		euler.setFromQuaternion(quaternion);

        euler.x += x;
		euler.y += y;
        euler.z += z;

        this.delegate.controlsRequireObjectRotation(
            this,
            this.objectName,
            euler
        ); 
    }

    private performJump(command: SceneObjectCommandJump) {
        this.delegate.controlsRequireJump(this, this.objectName);
    }

    private performTeleport(command: SceneObjectCommandTeleport) {
        // @ts-ignore
        const x = command.position.x;
        // @ts-ignore
        const y = command.position.y;
        // @ts-ignore
        const z = command.position.z;
        
        this.delegate.controlsRequireObjectTeleport(this, this.objectName, x, y, z);
    }
}