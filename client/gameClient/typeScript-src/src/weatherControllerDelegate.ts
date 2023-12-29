import { WeatherController } from "./weatherController.js";

export interface WeatherControllerDelegate {
    weatherControllerDidRequireIntancedMeshToScene(
        weatherController: WeatherController,
        instancedMesh: any
    ): void;
}