import { int } from "./types"

export class SceneObjectCommand {
    name: String
    time: int
    nextCommand?: SceneObjectCommand

    constructor(
        name: String,
        time: int
    )
    {
        this.name = name;
        this.time = time;
    }

    public step() {
        this.time -= 1;
    }

    public isExpired() {
        return this.time < 1;
    }
}