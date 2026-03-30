from PIL import Image, ImageDraw

def generate_icon(filename, draw_func):
    img = Image.new('RGBA', (32, 32), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    draw_func(draw)
    img.save(filename)
    print(f'Generated {filename}')

def draw_hoe(draw):
    draw.line([(5, 27), (25, 5)], fill=(150, 100, 50, 255), width=3)
    draw.polygon([(20, 10), (25, 5), (30, 10), (20, 20)], fill=(200, 200, 200, 255))

def draw_watercan(draw):
    draw.rectangle([10, 15, 25, 30], fill=(100, 150, 200, 255))
    draw.arc([5, 15, 15, 25], 90, 270, fill=(100, 150, 200, 255), width=2)
    draw.line([(25, 20), (30, 10)], fill=(100, 150, 200, 255), width=3)

def draw_seeds_icon(draw):
    draw.ellipse([12, 18, 16, 22], fill=(50, 200, 50, 255))
    draw.ellipse([16, 22, 20, 26], fill=(50, 200, 50, 255))

def draw_tomato(draw):
    draw.ellipse([5, 10, 27, 30], fill=(255, 0, 0, 255))
    draw.polygon([(16, 5), (12, 10), (20, 10)], fill=(0, 150, 0, 255))

def draw_selection(draw):
    draw.rectangle([0, 0, 31, 31], outline=(255, 255, 0, 255), width=3)

generate_icon('Images/icon_hoe.png', draw_hoe)
generate_icon('Images/icon_watercan.png', draw_watercan)
generate_icon('Images/icon_seeds.png', draw_seeds_icon)
generate_icon('Images/icon_tomato.png', draw_tomato)
generate_icon('Images/icon_select.png', draw_selection)
