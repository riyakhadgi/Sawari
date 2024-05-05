from channels.generic.websocket import AsyncWebsocketConsumer
import json
from asgiref.sync import async_to_sync

class NotificationConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.room_name = 'notifications'
        self.room_group_name = 'notifications_group'
        await self.channel_layer.group_add(
            self.room_group_name,
            self.channel_name
        )
        await self.accept()
        await self.send(text_data=json.dumps({
            'message': 'Connected to the server'
        }))

    async def disconnect(self, close_code):
        await self.channel_layer.group_discard(
            self.room_group_name,
            self.channel_name
        )

    async def receive(self, text_data):
        # No need to print the received data, directly send it back
        await self.send(text_data=text_data)

    async def notify_driver(self, event):
        message = event['message']
        print('Notification:')
        await self.channel_layer.group_send(
            self.room_group_name,
            {
                'type': 'send_notification',
                'message': message,
                'data': {
                    'name': 'John Doe',
                    'pickupLocation': 'Kathmandu',
                    'dropLocation': 'Pokhara',
                    'fare': 1000,
                    'distance': 200,
                }
            }
        )

    async def notify_user(self, event):
        message = event['message']
        await self.send(text_data=json.dumps({
            'message': message
        }))

    async def send_notification(self, event):
        message = event['message']
        # Send the message to the WebSocket client
        await self.send(text_data=json.dumps({
            'message': message
        }))
