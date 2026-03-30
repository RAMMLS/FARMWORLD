from PIL import Image, ImageDraw

def draw_interior(draw, size):
    w, h = size
    draw.rectangle([0, 0, w, h], fill=(139, 69, 19, 255))
    draw.rectangle([0, 0, w, h*0.2], fill=(200, 180, 150, 255))
    draw.rectangle([w*0.3, h*0.3, w*0.7, h*0.8], fill=(150, 50, 50, 255))
    draw.rectangle([w*0.4, h*0.1, w*0.6, h*0.25], fill=(100, 50, 20, 255))
    draw.rectangle([w*0.45, h*0.9, w*0.55, h], fill=(0, 0, 0, 255))

img = Image.new('RGBA', (800, 600), (0, 0, 0, 0))
draw = ImageDraw.Draw(img)
draw_interior(draw, (800, 600))
img.save('Images/interior_gen.png')
print('Generated interior_gen.png')
