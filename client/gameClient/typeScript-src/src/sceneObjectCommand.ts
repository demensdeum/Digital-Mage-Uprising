import { int } from "./types"

export class SceneObjectCommand {
    time: int

    constructor(
        time: int
    )
    {
        this.time = time;
    }

    public step() {
        this.time -= 1;
    }

    public isExpired() {
        return this.time < 1;
    }
}