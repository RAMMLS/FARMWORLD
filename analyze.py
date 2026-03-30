from PIL import Image

try:
    img = Image.open('Images/sprites_1.png')
    print('Size:', img.size)
except Exception as e:
    print('Error:', e)
