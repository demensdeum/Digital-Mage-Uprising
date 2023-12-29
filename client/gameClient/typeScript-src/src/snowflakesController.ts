// @ts-ignore
import * as THREE from "https://cdn.jsdelivr.net/npm/three@0.114/build/three.module.js";

// @ts-ignore
import { GLTFLoader } from "https://cdn.jsdelivr.net/npm/three@0.114/examples/jsm/loaders/GLTFLoader.js";

import { Paths } from "./paths.js";
import { WeatherController } from "./weatherController.js";
import { int } from "./types.js";

export class SnowflakesController implements WeatherController {

    private readonly modelLoader = new GLTFLoader();
    private readonly snowflakeModelPath = "com.demensdeum.snowflake.model";

    private instancedSnowflakeMesh?: any;
    private readonly snowflakesCount: int = 10;

    constructor(
        count: int
    )
    {
        const self = this;
        this.modelLoader.load(
            Paths.modelPath(this.snowflakeModelPath),
            // @ts-ignore
            (container) => {
                const model = container.scene;
                // @ts-ignore                
                model.traverse((mesh) => {
                    self.instancedSnowflakeMesh = new THREE.InstancedMesh(
                        mesh,
                        mesh.material, 
                        self.snowflakesCount
                    );
                })
            });
    }

    step(delta: any) {
        this.changeSnowflakesPosition();
    }

    private changeSnowflakesPosition()  {

    }
}