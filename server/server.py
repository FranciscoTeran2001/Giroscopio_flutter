import asyncio
import websockets
import webbrowser
import subprocess

async def handle_commands(websocket):
    async for command in websocket:
        print(f"Comando recibido: {command}")
        if command == 'open_browser':
            webbrowser.open('https://www.google.com/search?q=asodkma&oq=asodkma&gs_lcrp=EgZjaHJvbWUyBggAEEUYOdIBBzI4NmowajeoAgCwAgA&sourceid=chrome&ie=UTF-8')
        elif command == 'open_office':
            subprocess.Popen(['start', 'winword'], shell=True)
        elif command == 'open_media_player':
            subprocess.Popen(['start', 'ms-media-player:'], shell=True)
            pass

async def main():
    async with websockets.serve(handle_commands, '0.0.0.0', 8000):
        await asyncio.Future()

asyncio.run(main())