import { CommandsFactory } from "./commandsFactory.js";
import { Controls } from "./controls";
import { ControlsDelegate } from "./controlsDelegate";
import { ControlsDataSource } from "./playerControlsDataSource.js";
import { debugPrint } from "./runtime.js";
import { SceneObjectCommand } from "./sceneObjectCommand.js";
import { SceneObjectCommandType } from "./sceneObjectCommandType.js";
import { Utils } from "./utils.js";
import { Euler } from "./euler.js";

//ThreeJS

export class EnemyControls implements Controls {
    public delegate: ControlsDelegate;
    public dataSource: ControlsDataSource;
    private objectName: string;

    private moveCommand: SceneObjectCommand = CommandsFactory.idle(0);
    private secondaryMoveCommand: SceneObjectCommand = CommandsFactory.idle(0);    
    private extraMoveCommand: SceneObjectCommand = CommandsFactory.idle(0);   
    private rotationCommand: SceneObjectCommand = CommandsFactory.idle(0); 
    private actionCommand: SceneObjectCommand = CommandsFactory.idle(0);

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
            return CommandsFactory.rotateLeft(Utils.randomInt(100));
        }
        else if (idea == 14) {
            return CommandsFactory.rotateRight(Utils.randomInt(100));
        }
        return CommandsFactory.idle(Utils.randomInt(10));
    }

    private comeUpWithIdeaForMoveCommand() {
        const idea = Utils.randomInt(30);
        if (idea > 6  && idea < 20) {
            return CommandsFactory.moveForward(100 + Utils.randomInt(1000));
        }
        else if (idea == 4) {
            return CommandsFactory.moveBackward(100 + Utils.randomInt(1000));
        }        
        return CommandsFactory.idle(Utils.randomInt(10));
    }

    private comeUpWithIdeaForSecondaryMoveCommand() {
        const idea = Utils.randomInt(30);
        if (idea == 3) {
            return CommandsFactory.jump(10);
        }
        return CommandsFactory.idle(Utils.randomInt(10));
    }

    private comeUpWithIdeaForExtraMoveCommand() {
        const idea = Utils.randomInt(30);
        if (idea == 4) {
            return CommandsFactory.moveLeft(100 + Utils.randomInt(500));
        }
        else if (idea == 6) {
            return CommandsFactory.moveRight(100 + Utils.randomInt(500));
        }
        return CommandsFactory.idle(Utils.randomInt(10));
    }

    private handleCommand(command: SceneObjectCommand) {
        switch (command.type) {
            case SceneObjectCommandType.idle:
                break
                
            case SceneObjectCommandType.moveForward:
                this.moveForward();
                break

            case SceneObjectCommandType.moveBackward:
                this.moveBackward();
                break

            case SceneObjectCommandType.moveLeft:
                this.moveLeft();
                break

            case SceneObjectCommandType.moveRight:
                this.moveRight();
                break

            case SceneObjectCommandType.jump:
                this.jump();
                break

            case SceneObjectCommandType.rotateLeft:
                this.rotateLeft();
                break

            case SceneObjectCommandType.rotateRight:
                this.rotateRight();
                break
        }
        command.step();   
    }

    private moveForward() {
        if (
            this.dataSource.controlsCanMoveForwardObject(
            this, 
            this.objectName
            )
        ) {
            this.delegate.controlsRequireObjectTranslate(
                this,
                this.objectName,
                0,
                0, 
                -0.05
            );
        }
    }

    private moveBackward() {
        if (
            this.dataSource.controlsCanMoveBackwardObject(
            this, 
            this.objectName
            )
        ) {
            this.delegate.controlsRequireObjectTranslate(
                this,
                this.objectName,
                0,
                0, 
                0.05
            );
        }        
    }

    private moveLeft() {
        if (
            this.dataSource.controlsCanMoveLeftObject(
            this, 
            this.objectName
            )
        ) {
            this.delegate.controlsRequireObjectTranslate(
                this,
                this.objectName,
                -0.1,
                0, 
                0
            );
        }
    }

    private moveRight() {
        if (
            this.dataSource.controlsCanMoveRightObject(
            this, 
            this.objectName
            )
        ) {
            this.delegate.controlsRequireObjectTranslate(
                this,
                this.objectName,
                0.1,
                0, 
                0
            );
        }
    }

    private rotateLeft() {
        const euler = new Euler(0, 0, 0, 'YXZ' );        
        const quaternion = this.dataSource.controlsQuaternionForObject(
            this,
            this.objectName
        );

        // @ts-ignore
		euler.setFromQuaternion(quaternion);

        const PI_2 = Math.PI / 2;   

		euler.y += 0.1;

        this.delegate.controlsRequireObjectRotation(
            this,
            this.objectName,
            euler
        );
    }

    private rotateRight() {
        const euler = new Euler(0, 0, 0, 'YXZ' );        
        const quaternion = this.dataSource.controlsQuaternionForObject(
            this,
            this.objectName
        );

        // @ts-ignore
		euler.setFromQuaternion(quaternion);

        const PI_2 = Math.PI / 2;   

		euler.y -= 0.1;

        this.delegate.controlsRequireObjectRotation(
            this,
            this.objectName,
            euler
        );
    }

    private jump() {
        this.delegate.controlsRequireJump(this, this.objectName);
    }
};