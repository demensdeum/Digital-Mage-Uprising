// @ts-ignore
import * as THREE from "https://cdn.jsdelivr.net/npm/three@0.114/build/three.module.js";

// @ts-ignore
import { GLTFLoader } from "https://cdn.jsdelivr.net/npm/three@0.114/examples/jsm/loaders/GLTFLoader.js";

import { Paths } from "./paths.js";
import { WeatherController } from "./weatherController.js";
import { int } from "./types.js";
import { WeatherControllerDelegate } from "./weatherControllerDelegate.js";
import { Utils } from "./utils.js";

export class SnowflakesController implements WeatherController {

    private readonly modelLoader = new GLTFLoader();
    private readonly snowflakeModelPath = "com.demensdeum.snowflake";

    private instancedSnowflakeMesh?: any;
    private readonly snowflakesCount: int = 10;

    private delegate: WeatherControllerDelegate;

    private position = new THREE.Vector3();
    private matrix = new THREE.Matrix4();


    constructor(
        delegate: WeatherControllerDelegate
    )
    {
        this.delegate = delegate;
    }

    initialize()
    {
        const self = this;
        this.modelLoader.load(
            Paths.modelPath(this.snowflakeModelPath),
            // @ts-ignore
            (container) => {
                const model = container.scene;
                // @ts-ignore                
                model.traverse((entity) => {
                    if (entity.isMesh) {
                        const mesh = entity;
                        const material = new THREE.MeshNormalMaterial();
                        self.instancedSnowflakeMesh = new THREE.InstancedMesh(
                            mesh.geometry,
                            material, 
                            self.snowflakesCount
                        );


                        for (let i = 0; i < this.snowflakesCount; i++) {
                            this.position.x = 2 + i / 10.0;
                            this.position.y = 0;
                            this.position.z = -2;
                            
                            const quaternion = new THREE.Quaternion();
                            // quaternion.random();

                            const scale = new THREE.Vector3();
                            scale.x = 1;
                            scale.y = 1;
                            scale.z = 1;

                            this.matrix.compose(this.position, quaternion, scale );
                            self.instancedSnowflakeMesh.setMatrixAt(i, this.matrix);
                        }

                        self.delegate.weatherControllerDidRequireToAddInstancedMeshToScene(
                            self, 
                            self.instancedSnowflakeMesh
                        );

                        return;
                    }
                })
            });        
    }

    step(delta: any) {
        this.changeSnowflakesPosition();
    }

    private changeSnowflakesPosition()  {
        if (!this.instancedSnowflakeMesh) {
            return;
        }
        for (let i = 0; i < this.snowflakesCount; i++) {
            this.instancedSnowflakeMesh.getMatrixAt(i, this.matrix);
            this.position.setFromMatrixPosition(this.matrix);
            this.position.y -= 0.01;
            this.matrix.setPosition(this.position);
            this.instancedSnowflakeMesh.setMatrixAt(i, this.matrix);
            this.instancedSnowflakeMesh.instanceMatrix.needsUpdate = true;
        }
    }
}