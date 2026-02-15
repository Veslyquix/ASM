import os
from PIL import Image
from collections import defaultdict

PNG_FOLDER = "png"
OUTPUT_FILE = "GeneratedInstaller.event"

def rgb8_to_gba5(value):
    return value >> 3

def get_palette_colors(path):
    """
    Returns the 15 visible palette colors (skipping index 0)
    as a list of (r, g, b) tuples.
    """
    img = Image.open(path)

    if img.mode != "P":
        raise ValueError(f"{path} is not indexed (mode P).")

    palette = img.getpalette()  # flat list [r,g,b,r,g,b,...]
    colors = []

    for i in range(1, 16):  # skip index 0
        r8 = palette[i * 3 + 0]
        g8 = palette[i * 3 + 1]
        b8 = palette[i * 3 + 2]

        r5 = rgb8_to_gba5(r8)
        g5 = rgb8_to_gba5(g8)
        b5 = rgb8_to_gba5(b8)

        colors.append((r5, g5, b5))


    return colors


def format_rgb(color):
    r, g, b = color
    return f"rgb({r}, {g}, {b})"


def main():
    # Group files by base name
    groups = defaultdict(list)

    for file in os.listdir(PNG_FOLDER):
        if not file.lower().endswith(".png"):
            continue

        name = os.path.splitext(file)[0]
        if "_" not in name:
            continue  # skip malformed names

        base, variant = name.split("_", 1)
        groups[base].append((variant, os.path.join(PNG_FOLDER, file)))

    with open(OUTPUT_FILE, "w") as out:

        for base in sorted(groups.keys()):
            variants = groups[base]
            count = len(variants)

            # Find the Base variant first
            base_palette = None
            for variant, path in variants:
                if variant.lower() == "00base":
                    base_palette = get_palette_colors(path)
                    break

            if base_palette is None:
                print(f"Warning: No base variant found for {base}")
                continue

            for variant, path in sorted(variants):
                colors = get_palette_colors(path)

                output_entries = []

                for color, base_color in zip(colors, base_palette):
                    if color == base_color:
                        output_entries.append("skip")
                    else:
                        r, g, b = color
                        output_entries.append(f"rgb({r}, {g}, {b})")

                rgb_list = ", ".join(output_entries)

                line = (
                    f"PortraitPals({base}_Base, "
                    #f"{base}_Base+{count}, "
                    f"{base}_Base+NumOfPortraits, "
                    f"{base}Flag_{variant}, "
                    f"{rgb_list})"
                )

                out.write(line + "\n")


    print("Done! GeneratedInstaller.event created.")


if __name__ == "__main__":
    main()
