from channels.generic.websocket import AsyncWebsocketConsumer
import json

class NotificationConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        await self.accept()

    async def disconnect(self, close_code):
        pass

    async def receive(self, text_data):
        # No need to print the received data, directly send it back
        await self.send(text_data=text_data)

    async def notify_driver(self, event):
        message = event['message']
        # Send the message to the WebSocket client
        await self.send(text_data=json.dumps({
            'message': message
        }))


    async def notify_user(self, event):
        message = event['message']
        await self.send(text_data=json.dumps({
            'message': message
        }))
