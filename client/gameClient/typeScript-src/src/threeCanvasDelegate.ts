import { SceneObject } from "./sceneObject";

export interface ThreeCanvasDelegate {
    threeCanvasDidUpdateCanvas(
        threeCanvas: any, 
        canvas: any
    ): void;
}