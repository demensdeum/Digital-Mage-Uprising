import { WeatherController } from "./weatherController.js";
import { int } from "./types.js";

export class SnowflakesController implements WeatherController {

    private snowflakeModelPath = "com.demensdeum.snowflake.model";

    constructor(
        count: int
    )
    {
        
    }

    step(delta: any) {
        this.changeSnowflakesPosition();
    }

    private changeSnowflakesPosition()  {

    }
}