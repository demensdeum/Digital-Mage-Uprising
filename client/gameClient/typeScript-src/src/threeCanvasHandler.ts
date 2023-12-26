import { ThreeCanvasDelegate } from "./threeCanvasDelegate";

export class ThreeCanvasHandler implements ThreeCanvasDelegate {
    private application: any;

    threeCanvasDidUpdateCanvas(
        threeCanvas: any, 
        canvas: any
    ) {
        const output = JSON.stringify(canvas);
        this
            .application
            .ports
            .nativeCanvasReceiver
            .send(output);
            console.log("sent canvas to Elm");            
    }
}

// @ts-ignore
document.threeCanvasHandlerLoaded(new ThreeCanvasHandler());