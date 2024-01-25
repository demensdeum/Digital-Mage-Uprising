import { Controls } from "./controls";

class Texture {
    public readonly name: string;
    constructor(name: string) {
        this.name = name;
    }
}

class Model {
    public readonly name: string;
    constructor(name: string) {
        this.name = name;
    }
}

export class SceneObject {
    public readonly name: string;
    public readonly type: string;
    public readonly texture: Texture;
    public readonly model: Model;
    public threeObject: any; 
    public meshes: any[] = [];
    public readonly isMovable: boolean;
    public controls?: Controls;

    constructor(
        name: string,
        type: string,
        texture: string,
        model: string,
        threeObject: any,
        movable: boolean = false,
        controls: Controls| null = null
    ) {
        this.name = name;
        this.type = type;
        this.texture = new Texture(texture);
        this.model = new Model(model);
        this.threeObject = threeObject;
        this.isMovable = movable;
        if (controls != null) {
            this.controls = controls;
        }
    }

    public serialize(): any {

        var controlsName = "NONE"
        var controlsStartCommand = "NONE"

        const output = {
            "name" : this.name,
            "type" : this.type,
            "texture" : this.texture,
            "model" : this.model,
            "position" : {
                "x" : this.threeObject.position.x,
                "y" : this.threeObject.position.y,
                "z" : this.threeObject.position.z
            },
            "rotation" : {
                "x" : this.threeObject.rotation.x,
                "y" : this.threeObject.rotation.y,
                "z" : this.threeObject.rotation.z
            },
            "isMovable" : this.isMovable,
            "controls": {
                "name": controlsName,
                "startCommand": controlsStartCommand
            }
        }
        return output;
    }
}