import { CommandsFactory } from "./commandsFactory.js";
import { Controls } from "./controls";
import { ControlsDelegate } from "./controlsDelegate";
import { ControlsDataSource } from "./playerControlsDataSource.js";
import { debugPrint } from "./runtime.js";
import { SceneObjectCommand } from "./sceneObjectCommand.js";
import { SceneObjectCommandType } from "./sceneObjectCommandType.js";
import { Utils } from "./utils.js";

export class EnemyControls implements Controls {
    public delegate: ControlsDelegate;
    public dataSource: ControlsDataSource;
    private objectName: string;

    private moveCommand: SceneObjectCommand = CommandsFactory.idle(0);
    private secondaryMoveCommand: SceneObjectCommand = CommandsFactory.idle(0);
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
            this.secondaryMoveCommand = this.comeUpWithIdeaForMoveCommand();
        }
    }

    private comeUpWithIdeaForMoveCommand() {
        const idea = Utils.randomInt(30);
        if (idea == 3) {
            return CommandsFactory.moveForward(100 + Utils.randomInt(100));
        }
        else if (idea == 4) {
            return CommandsFactory.moveLeft(100 + Utils.randomInt(100));
        }        
        else if (idea == 22) {
            return CommandsFactory.moveRight(100 + Utils.randomInt(100));
        }
        else if (idea == 8) {
            return CommandsFactory.jump(Utils.randomInt(100));
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
                -0.01
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
                -0.01,
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
                0.01,
                0, 
                0
            );
        }
    }    

    private jump() {
        this.delegate.controlsRequireJump(this, this.objectName);
    }
};