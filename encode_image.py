import os
import base64
# Odoo API authentication

file_path = "news.png"
with open(file_path, 'rb') as f:
  data = f.read()
  encoded_image_data = base64.b64encode(data)
  ImageSend = encoded_image_data.decode('ascii')
  print(ImageSend)