from PIL import Image, ImageDraw

def generate_pixel_art(filename, size, draw_func):
    img = Image.new('RGBA', size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    draw_func(draw, size)
    img.save(filename)
    print(f'Generated {filename}')

def draw_player(draw, size):
    w, h = size
    # Тело (комбинезон)
    draw.rectangle([w*0.2, h*0.4, w*0.8, h*0.9], fill=(50, 100, 200, 255))
    # олова
    draw.rectangle([w*0.25, h*0.1, w*0.75, h*0.4], fill=(255, 200, 150, 255))
    # олосы
    draw.rectangle([w*0.2, h*0.05, w*0.8, h*0.2], fill=(200, 100, 50, 255))
    # лаза
    draw.rectangle([w*0.35, h*0.25, w*0.45, h*0.3], fill=(0, 0, 0, 255))
    draw.rectangle([w*0.55, h*0.25, w*0.65, h*0.3], fill=(0, 0, 0, 255))
    # оги
    draw.rectangle([w*0.25, h*0.9, w*0.45, h], fill=(100, 50, 20, 255))
    draw.rectangle([w*0.55, h*0.9, w*0.75, h], fill=(100, 50, 20, 255))

def draw_house(draw, size):
    w, h = size
    # Стены
    draw.rectangle([w*0.1, h*0.4, w*0.9, h], fill=(200, 150, 100, 255))
    # рыша
    draw.polygon([(0, h*0.4), (w/2, 0), (w, h*0.4)], fill=(180, 50, 50, 255))
    # верь
    draw.rectangle([w*0.4, h*0.6, w*0.6, h], fill=(100, 50, 20, 255))
    # кно
    draw.rectangle([w*0.2, h*0.5, w*0.35, h*0.7], fill=(100, 200, 255, 255))
    draw.rectangle([w*0.65, h*0.5, w*0.8, h*0.7], fill=(100, 200, 255, 255))

def draw_tree(draw, size):
    w, h = size
    # Ствол
    draw.rectangle([w*0.4, h*0.6, w*0.6, h], fill=(120, 70, 30, 255))
    # рона (несколько кругов)
    draw.ellipse([w*0.1, h*0.2, w*0.9, h*0.7], fill=(34, 139, 34, 255))
    draw.ellipse([w*0.2, 0, w*0.8, h*0.5], fill=(50, 180, 50, 255))
    # Яблоки
    draw.ellipse([w*0.3, h*0.3, w*0.4, h*0.4], fill=(255, 0, 0, 255))
    draw.ellipse([w*0.6, h*0.4, w*0.7, h*0.5], fill=(255, 0, 0, 255))
    draw.ellipse([w*0.5, h*0.15, w*0.6, h*0.25], fill=(255, 0, 0, 255))

def draw_ui(draw, size):
    w, h = size
    # он панели
    draw.rectangle([0, 0, w, h], fill=(150, 100, 50, 255), outline=(100, 50, 20, 255), width=4)
    # Слоты инвентаря
    slots = 8
    slot_w = (w - 40) / slots
    for i in range(slots):
        x = 20 + i * slot_w
        draw.rectangle([x+2, 10, x+slot_w-2, h-10], fill=(200, 150, 100, 255), outline=(80, 40, 10, 255), width=2)

import os
if not os.path.exists('Images'):
    os.makedirs('Images')

generate_pixel_art('Images/player_gen.png', (32, 64), draw_player)
generate_pixel_art('Images/house_gen.png', (200, 200), draw_house)
generate_pixel_art('Images/tree_gen.png', (100, 150), draw_tree)
generate_pixel_art('Images/ui_gen.png', (400, 60), draw_ui)
