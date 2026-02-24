import numpy as np
from PIL import Image
import os

# Define a full permutation mapping
PERM = {

    2: 1,
    4: 2,
    7: 3,
    8: 4,
    1: 6,
    3: 7,
    6: 8, 
}

for file in os.listdir():
    if not file.lower().endswith(".png"):
        continue

    img = Image.open(file)

    original_palette = np.array(img.getpalette(), dtype=np.uint8).reshape(-1, 3)

    # Start with identity permutation
    new_palette = original_palette.copy()

    # Apply permutation safely
    for src, dst in PERM.items():
        new_palette[dst] = original_palette[src]

    # Remap pixels
    pixels = np.array(img)

    new_pixels = pixels.copy()
    for src, dst in PERM.items():
        new_pixels[pixels == src] = dst

    # Build image
    new_img = Image.fromarray(new_pixels.astype(np.uint8), mode="P")
    new_img.putpalette(new_palette.flatten().tolist())

    new_img.save(file)

print("Saved images.")
