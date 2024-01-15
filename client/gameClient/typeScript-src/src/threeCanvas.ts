// eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-nocheck

import { SceneController } from './sceneController.js';
import { Names } from './names.js'
import { PlayerControls } from "./playerControls.js";
import { SimplePhysicsController } from './simplePhysicsController.js';
import { EnemyControls } from './enemyControls.js';
import { debugPrint } from './runtime.js';

customElements.define('three-canvas',
    class extends HTMLElement {
        constructor() {
            super();
            this.playerControls = null;
            this.delegate = null;
            this.canvas = null;
            this.debugEnabled = false;

            this.resetCanvas();
            this.innerHTML = "<canvas class=\"webgl\"></canvas>";

            this.graphicsCanvas = document.querySelector("canvas");

            if (this.graphicsCanvas == null) {
                console.log("CANVAS IS NULL WTF?????!!!!");
                return;
            }

            this.physicsController = new SimplePhysicsController(
                false
            );            

            this.sceneController = new SceneController(
                this.graphicsCanvas,
                this.physicsController,
                false
            );          

            document.threeCanvasDidLoad(this);

            const threeCanvas = this;
            const sceneController = this.sceneController;         

            const sceneControllerRender = () => {
                sceneController.step();
                
                if (threeCanvas.canvas != null) {
                    threeCanvas.canvas = {
                        "scene" : {
                            "name" : threeCanvas.canvas.scene.name,
                            "objects" : sceneController.serializedSceneObjects(),
                            "physicsEnabled" : threeCanvas.canvas.scene.physicsEnabled
                        },
                        "message" : "JS OVERRIDE",
                        "userObjectName" : threeCanvas.canvas.userObjectName            
                    }
                    if (threeCanvas.delegate) {
                        threeCanvas.delegate.threeCanvasDidUpdateCanvas(threeCanvas, threeCanvas.canvas);
                    }
                    else {
                        console.log("threeCanvas.delegate is null - nowhere to signal!!!!");
                    }
                }

                requestAnimationFrame(sceneControllerRender);
            };

            sceneControllerRender(this, this.sceneController);
        }

        static get observedAttributes() {
            return ['scene-json'];
        }
        
        resetCanvas() {
            this.canvas = {
                scene: {
                    name: "",
                    objects: {},
                },
                message: "No message"                
            };            
        }

        attributeChangedCallback(name, oldValue, newValue) {
            if (this.debugEnabled) {
                console.log("ThreeCanvas attribute changed!!!");
            }
            const canvasJson = newValue;
            const canvas = JSON.parse(canvasJson);
            this.render(canvas);
        }

        render(canvas)
        {
            if (
                this.playerControls == null &&
                canvas.userObjectName != null &&
                canvas.userObjectName.length > 0
            ) {
                if (confirm("You AI?")) {
                    this.playerControls = new EnemyControls(
                        canvas.userObjectName,
                        this.sceneController,
                        this.sceneController
                    );                    
                }
                else {
                    this.playerControls = new PlayerControls(
                        canvas.userObjectName,
                        this.graphicsCanvas,
                        4,
                        true,
                        this.sceneController,
                        this.sceneController
                    );
                }

                this.sceneController.playerControls = this.playerControls;
            }
            if (canvas.scene == null || canvas.scene == undefined) {
                debugPrint("AAAAAAHHH MODEL SCENE IS EMPTY - CAN'T RENDER!!!!!!");
                return;
            }
            
            if (this.canvas.scene.name != canvas.scene.name) {
                debugger;
                console.log("clear");
                this.resetCanvas();
                this.sceneController.removeAllSceneObjectsExceptCamera();
            }

            this.sceneController.userObjectName = canvas.userObjectName;

            Object.values(canvas.scene.objects).forEach ((object) => {
                const name = object.name;
                const type = object.type;
                const textureName = object.texture.name;   

                const x = object.position.x;
                const y = object.position.y;
                const z = object.position.z;

                const rX = object.rotation.x;
                const rY = object.rotation.y;
                const rZ = object.rotation.z;

                const isMovable = object.isMovable;

                const modelName = object.model.name;

                if (this.debugEnabled) {
                    console.log("name: " + name + " x: " + x + " y: " + y + " z: " + z );
                }

                if (name in this.canvas.scene.objects) {
                    this.sceneController.moveObjectTo(
                        name,
                        x,
                        y,
                        z
                    );
                    this.sceneController.rotateObjectTo(
                        name,
                        rX,
                        rY,
                        rZ
                    )
                }
                else {
                    if (type == "Skybox") {
                        this.sceneController.addSkybox(
                            textureName
                        );
                    }
                    else if (type == "Model") {
                        if (modelName == "default") {
                            this.sceneController.addBoxAt(
                                name,
                                x,
                                y,
                                z
                            );    
                        }
                        else {
                            this.sceneController.addModelAt(
                                name,
                                modelName,
                                x,
                                y,
                                z,
                                rX,
                                rY,
                                rZ,
                                isMovable
                            );    
                        }
                    }
                    else if (type == "Camera") {
                        this.canvas.scene.objects["Camera"] = this.sceneController.serializeSceneObject(Names.Camera);
                        this.sceneController.moveObjectTo(
                            Names.Camera,
                            x,
                            y,
                            z
                        )
                    }
                    else if (type == "Box") {
                        this.sceneController.addBoxAt(
                            name,
                            x,
                            y,
                            z
                        )                       
                        return;
                    }
                    else if (type == "Button") {
                        const self = this;
                        let action = () => {
                            debugPrint("Button " + name + " Pressed!!!")
                            self.delegate.threeCanvasButtonDidPress(
                                self,
                                name
                            )
                        }
                        var button = {
                            [name] : action
                        }
                        this.sceneController.addButton(
                            name,
                            button
                        )
                    }
                    else {
                        debugPrint("Unknown object type: " + type + "; uhh what the hell???");
                    }
                }
            });
            this.canvas = canvas;
            if (this.debugEnabled) {
                //debugger;
            }
        }
    }
);