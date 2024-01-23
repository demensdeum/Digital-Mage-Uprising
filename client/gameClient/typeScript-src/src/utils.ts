export class Utils {
    public static angleToRadians(angle: number) {
        return angle * Math.PI / 180;
    }

    public static randomInt(max: number) {
        return Math.floor(Math.random() * max);
    }

    public static randomFloat(max: number) {
        return Math.random() * max;
    }

    public static randomBool() {
        const randomBool = (): boolean => Math.random() < 0.5;
        return randomBool;
    }

    public static radiansToAngle(radians: number) {
        return radians * 180 / 3.14;
    }

    public static shuffle<T>(array: T[]): T[] {
        let currentIndex = array.length, randomIndex;
        while (currentIndex != 0) {
          randomIndex = Math.floor(Math.random() * currentIndex);
          currentIndex--;
          [array[currentIndex], array[randomIndex]] = [
            array[randomIndex], array[currentIndex]];
        }
        return array;
    };    
}