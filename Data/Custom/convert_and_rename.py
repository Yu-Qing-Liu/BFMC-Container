from pathlib import Path
from PIL import Image


def convert_and_rename(directory="./gt_image", sample=1):
    # Get all jpg files in directory
    jpg_files = list(Path(directory).glob("*.jpg"))

    # Sort files numerically by their filename stem
    try:
        sorted_files = sorted(jpg_files, key=lambda x: int(x.stem))
    except ValueError:
        print("Error: Non-numeric filename found. All files must have numeric names.")
        return

    # Convert and rename with sequential 4-digit numbering
    id = 1768
    for idx, jpg_path in enumerate(sorted_files):
        if idx % sample == 0:
            # Create new PNG filename
            png_name = f"{id:04}.png"
            png_path = jpg_path.with_name(png_name)

            # Convert image format using Pillow
            try:
                with Image.open(jpg_path) as img:
                    img.save(png_path, "PNG")

                # Remove original JPG after successful conversion
                jpg_path.unlink()
                print(f"Converted {jpg_path.name} => {png_name}")
                id += 1
            except Exception as e:
                print(f"Error processing {jpg_path.name}: {str(e)}")
        else:
            # Delete the file
            try:
                jpg_path.unlink()
            except Exception as e:
                raise e


if __name__ == "__main__":
    convert_and_rename()
