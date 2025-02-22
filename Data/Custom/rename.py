from pathlib import Path


def rename(directory="./gt_image", sample=1):
    # Get all png files in directory
    png_files = list(Path(directory).glob("*.png"))

    # Sort files numerically by their filename stem
    try:
        sorted_files = sorted(png_files, key=lambda x: int(x.stem))
    except ValueError:
        print("Error: Non-numeric filename found. All files must have numeric names.")
        return

    # Convert and rename with sequential 4-digit numbering
    id = 0
    for idx, png_path in enumerate(sorted_files):
        if idx % sample == 0:
            new_name = f"{id:04d}.png"
            new_path = png_path.parent / new_name
            png_path.rename(new_path)
            id += 1
        else:
            # Delete the file
            try:
                png_path.unlink()
            except Exception as e:
                raise e


if __name__ == "__main__":
    rename()
