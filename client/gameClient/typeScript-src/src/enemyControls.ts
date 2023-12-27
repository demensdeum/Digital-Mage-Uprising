import { Controls } from "./controls";
import { ControlsDelegate } from "./controlsDelegate";
import { debugPrint } from "./runtime";

export class EnemyControls implements Controls {
    delegate: ControlsDelegate;

    constructor(
        delegate: ControlsDelegate
    ) {
        this.delegate = delegate;
    }

    step(delta: any): void {
        debugPrint("derp derp derp");
    }
};