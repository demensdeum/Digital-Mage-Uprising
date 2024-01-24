import { float } from "./types.js"

export class GameSettings {

    static databaseKey = "GameSettings"

    mouseSensitivity: float

    static default()
    {
        return new GameSettings(
            4
        )
    }

    static fromJson(
        savedGameSettings: any
    )
    {
        return new GameSettings(
            savedGameSettings.mouseSensitivity
        )
    }

    constructor(
        mouseSensitivity: float
    )
    {
        this.mouseSensitivity = mouseSensitivity
    }

    save() {
        const serializedGameSettings = JSON.stringify(this)
        window.localStorage.setItem(GameSettings.databaseKey, serializedGameSettings)
    }

    static loadOrDefault(): GameSettings {
        const savedGameSettingsJson = window.localStorage.getItem(GameSettings.databaseKey)
        var savedGameSettings = null
        if (savedGameSettingsJson != null) {
            savedGameSettings = JSON.parse(savedGameSettingsJson)
        }
        const gameSettings = savedGameSettings != null ? GameSettings.fromJson(savedGameSettings) : GameSettings.default()
        return gameSettings
    }

}