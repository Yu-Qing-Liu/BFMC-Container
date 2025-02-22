from pathlib import Path
import numpy as np
import cv2


def apply_region_mask(directory="./gt_image", sample=1):
    """Apply a trapezoidal mask to images in the directory and save the results.

    Args:
        directory (str): Directory containing input images.
        sample (int): Sample every n-th image (default: 1 processes all).
    """
    png_files = list(Path(directory).glob("*.png"))

    # Process every sample-th image
    for idx, png_path in enumerate(png_files):
        if idx % sample != 0:
            continue

        image = cv2.imread(str(png_path))
        if image is None:
            continue

        # Create mask for the region of interest
        mask = np.zeros_like(image)

        # Define trapezoid vertices (adjusted for desired region)
        height, width = image.shape[:2]
        vertices = np.array([[
            (0, height),  # Bottom-left
            (width * 0.10, height * 0.6),  # Top-left
            (width * 0.90, height * 0.6),  # Top-right
            (width, height)  # Bottom-right
        ]], dtype=np.int32)

        cv2.fillPoly(mask, vertices, (255, 255, 255))

        # Apply mask to the image
        masked_image = cv2.bitwise_and(image, mask)

        # Save the result
        result_path = Path(directory) / f"{png_path.stem}.png"
        cv2.imwrite(str(result_path), masked_image)
        print(f"Saving {png_path.stem}.png")


if __name__ == "__main__":
    apply_region_mask(sample=1)  # Process all images
    apply_region_mask(directory="./gt_binary_image", sample=1)  # Process all images
    apply_region_mask(directory="./gt_instance_image", sample=1)  # Process all images
