import asyncio
import websockets

async def echo_server(websocket, path):
    try:
        async for message in websocket:
            print(f"Received message: {message}")
            await websocket.send(f"Echo: {message}")
    except websockets.exceptions.ConnectionClosed:
        print("Connection closed.")

if __name__ == "__main__":
    server_address = "localhost"
    server_port = 2938

    start_server = websockets.serve(echo_server, server_address, server_port)

    print(f"WebSocket server listening on ws://{server_address}:{server_port}")

    asyncio.get_event_loop().run_until_complete(start_server)
    asyncio.get_event_loop().run_forever()
