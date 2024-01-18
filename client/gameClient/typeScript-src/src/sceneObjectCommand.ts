import { int } from "./types"

export class SceneObjectCommand {
    name: String
    time: int
    nextCommandName?: String

    constructor(
        name: String,
        time: int,
        nextCommandName?: String
    )
    {
        this.name = name;
        this.time = time;
        if (nextCommandName != null) {
            this.nextCommandName = nextCommandName
        }
    }

    public step() {
        this.time -= 1;
    }

    public isExpired() {
        return this.time < 1;
    }
}