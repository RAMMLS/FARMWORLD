from PIL import Image
import os

def slice_sprites():
    if not os.path.exists('Images'): return
    
    # ткрываем первую картинку (спрайты)
    try:
        img1 = Image.open('Images/sprites_1.png')
        
        # арезаем базовые объекты (координаты примерные на основе типичных атласов, 
        # так как точные координаты неизвестны, мы сделаем умную нарезку или просто загрузим весь атлас в Godot)
        
        # место жесткой нарезки вслепую, создадим ресурсы AtlasTexture в Godot!
        pass
    except Exception as e:
        print(f'Error: {e}')

slice_sprites()
