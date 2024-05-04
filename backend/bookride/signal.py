from channels.layers import get_channel_layer
from asgiref.sync import async_to_sync

channel_layer = get_channel_layer()

# Inside your Django views or signals
async_to_sync(channel_layer.group_send)(
    "notifications_group",
    {
        "type": "notify_driver",
        "message": "New ride request",
    }
)

async_to_sync(channel_layer.group_send)(
    "notifications_group",
    {
        "type": "notify_user",
        "message": "Driver accepted your ride request",
    }
)
