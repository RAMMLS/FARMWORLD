from PIL import Image, ImageDraw

def generate_pixel_art(filename, size, draw_func):
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    draw_func(draw, size)
    img.save(filename)
    print(f'Generated {filename}')

def draw_seed(draw, size):
    w, h = size
    draw.rectangle([0, 0, w, h], fill=(101, 50, 14, 255))
    draw.rectangle([w*0.45, h*0.6, w*0.55, h*0.8], fill=(50, 200, 50, 255))
    draw.ellipse([w*0.3, h*0.5, w*0.5, h*0.6], fill=(50, 200, 50, 255))
    draw.ellipse([w*0.5, h*0.5, w*0.7, h*0.6], fill=(50, 200, 50, 255))

def draw_plant_mid(draw, size):
    w, h = size
    draw.rectangle([0, 0, w, h], fill=(101, 50, 14, 255))
    draw.rectangle([w*0.45, h*0.4, w*0.55, h*0.8], fill=(34, 139, 34, 255))
    draw.ellipse([w*0.2, h*0.3, w*0.8, h*0.6], fill=(34, 139, 34, 255))

def draw_plant_full(draw, size):
    w, h = size
    draw.rectangle([0, 0, w, h], fill=(101, 50, 14, 255))
    draw.rectangle([w*0.45, h*0.3, w*0.55, h*0.8], fill=(0, 100, 0, 255))
    draw.ellipse([w*0.1, h*0.1, w*0.9, h*0.6], fill=(0, 100, 0, 255))
    draw.ellipse([w*0.4, h*0.2, w*0.6, h*0.4], fill=(255, 0, 0, 255))

def draw_watered_soil(draw, size):
    w, h = size
    draw.rectangle([0, 0, w, h], fill=(60, 30, 10, 255))
    draw.rectangle([2, 2, w-2, h-2], fill=(50, 20, 5, 255))

generate_pixel_art('Images/seed_gen.png', (32, 32), draw_seed)
generate_pixel_art('Images/plant_mid_gen.png', (32, 32), draw_plant_mid)
generate_pixel_art('Images/plant_full_gen.png', (32, 32), draw_plant_full)
generate_pixel_art('Images/watered_soil_gen.png', (32, 32), draw_watered_soil)
