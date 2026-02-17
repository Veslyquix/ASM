import os
from PIL import Image
from collections import defaultdict

RECOLOURS_FOLDER = "portrait_recolours"
HAIRSTYLES_FOLDER = "portrait_hairstyles"
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
    recolours = defaultdict(list)
    hairstyles = defaultdict(list)

    for file in os.listdir(RECOLOURS_FOLDER):
        if not file.lower().endswith(".png"):
            continue

        name = os.path.splitext(file)[0]
        if "_" not in name:
            continue  # skip malformed names

        base, variant = name.split("_", 1)
        recolours[base].append((variant, os.path.join(RECOLOURS_FOLDER, file)))


    for file in os.listdir(HAIRSTYLES_FOLDER):
        if not file.lower().endswith(".png"):
            continue

        name = os.path.splitext(file)[0]
        if "_" not in name:
            continue  # skip 

        base, variant = name.split("_", 1)
        hairstyles[base].append((variant, os.path.join(HAIRSTYLES_FOLDER, file)))
    i = 0
    flag = 0
    with open(OUTPUT_FILE, "w") as out:
        
        total = 0
        out.write(f"//Generated! (No need to edit this file manually) \n")
        out.write(f"ALIGN 4\nDynamicPortraitTable:\n")
        for base in sorted(hairstyles.keys()):
            variants = hairstyles[base]
            count = len(variants)
            for c in range(count):
                if total != 0:
                    out.write(f"DynPor(StartingMug, StartingMug+{total}, StartingFlag+{total})\n")
                total+= 1
        out.write(f"WORD 0 0 //Terminator\n")
        out.write(f"\nALIGN 4\nNumHairstyles:\n")
        for base in sorted(hairstyles.keys()):
            variants = hairstyles[base]
            count = len(variants)
            out.write(f"BYTE {count} //{base}\n")
        out.write(f"BYTE 0 //Terminator\n")
        total = 0
        out.write(f"\nALIGN 4\nAvatarPortraits:\n")
        for base in sorted(hairstyles.keys()):
            variants = hairstyles[base]
            count = len(variants)
            out.write(f"SHORT StartingMug+{total} //{base}\n")
            total += count
        out.write(f"SHORT 0 //Terminator\n")

        total = 0
        out.write(f"\nALIGN 4\nMugFlags:\n")
        for base in sorted(hairstyles.keys()):
            variants = hairstyles[base]
            count = len(variants)
            out.write(f"SHORT StartingFlag+{total} //{base}\n")
            total += count
##        total -= 1
        out.write(f"SHORT 0 //Terminator\n")
        out.write(f"\nALIGN 4\nPortraitPalReplacements:\n")
        
        
 
        hairFlags = []
        skinFlags = []
        eyeFlags = []
        for base in sorted(recolours.keys()):
            variants = recolours[base]
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
                allBase = True

                for color, base_color in zip(colors, base_palette):
                    if color == base_color:
                        output_entries.append("skip")
                    else:
                        r, g, b = color
                        output_entries.append(f"rgb({r}, {g}, {b})")
                        allBase = False

                if allBase:
                    continue
                rgb_list = ", ".join(output_entries)
                flag = total + i

                line = (
                    f"PortraitPals(StartingMug, "
                    f"StartingMug+{total}, "
                    #f"{base}Flag_{variant}, "
                    f"StartingFlag+{flag}, "
                    f"{rgb_list})"
                )
                if "skin" in variant.lower():
                    skinFlags.append(flag)
                elif "eye" in variant.lower():
                    eyeFlags.append(flag)
                else:
                    hairFlags.append(flag)
                i+=1

                out.write(line + "\n")

        out.write(f"SHORT 0xFFFF 0xFFFF 0xFFFF 0xFFFF 0xFFFF 0xFFFF 0xFFFF 0xFFFF 0xFFFF 0xFFFF // Terminator\n")
        out.write(f"\nALIGN 4\nHairColFlags:\n")
        for h in range(len(hairFlags)):
            var = hairFlags[h]
            out.write(f"SHORT StartingFlag+{var}\n")
        out.write(f"SHORT 0 //Terminator\n")
        out.write(f"\nALIGN 4\nEyeColFlags:\n")
        for e in range(len(eyeFlags)):
            var = eyeFlags[e]
            out.write(f"SHORT StartingFlag+{var}\n")
        out.write(f"SHORT 0 //Terminator\n")
        out.write(f"\nALIGN 4\nSkinColFlags:\n")
        for s in range(len(skinFlags)):
            var = skinFlags[s]
            out.write(f"SHORT StartingFlag+{var}\n")
        out.write(f"SHORT 0 //Terminator\n")
        flag = hex(flag)
        out.write(f"\nALIGN 4\nAvatarTotalFlags:\nWORD {flag}")

    
    print(f"Done! GeneratedInstaller.event created.\n{flag} global flags used.")


if __name__ == "__main__":
    main()
