import { ControlsDelegate } from "./controlsDelegate";

export interface Controls {
    delegate: ControlsDelegate;
    step(delta: any): void;
}