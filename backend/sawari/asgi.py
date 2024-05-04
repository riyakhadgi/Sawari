import os
from django.core.asgi import get_asgi_application
from channels.routing import ProtocolTypeRouter, URLRouter
import bookride.routing

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'sawari.settings')

application = ProtocolTypeRouter({
    "http": get_asgi_application(),
    "websocket": URLRouter(
        bookride.routing.websocket_urlpatterns  # Use your WebSocket URL patterns
    ),
})
