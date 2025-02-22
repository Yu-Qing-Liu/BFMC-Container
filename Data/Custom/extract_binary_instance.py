import cv2
import numpy as np
import xml.etree.ElementTree as ET
from pathlib import Path

def extract_binary_instance(annotations_path):
    # Parse the XML file
    tree = ET.parse(annotations_path)
    root = tree.getroot()

    # Create output directories if they don't exist
    Path('gt_binary_image').mkdir(exist_ok=True)
    Path('gt_instance_image').mkdir(exist_ok=True)

    for image_elem in root.findall('image'):
        # Get image attributes
        img_name = image_elem.get('name')
        img_width = int(image_elem.get('width'))
        img_height = int(image_elem.get('height'))

        # Initialize binary and instance images with black background
        binary_img = np.zeros((img_height, img_width), dtype=np.uint8)
        instance_img = np.zeros((img_height, img_width), dtype=np.uint8)

        # Get all lane polylines
        lanes = image_elem.findall('polyline[@label="lane"]')
        num_lanes = len(lanes)

        for idx, lane in enumerate(lanes):
            # Parse points string into list of (x, y) tuples
            points_str = lane.get('points')
            points = []
            for p in points_str.split(';'):
                x, y = map(float, p.split(','))
                # Convert to integer coordinates, clamping to image dimensions
                x = int(round(x))
                y = int(round(y))
                x = max(0, min(img_width - 1, x))
                y = max(0, min(img_height - 1, y))
                points.append((x, y))

            # Skip if there are fewer than 2 points (can't draw a line)
            if len(points) < 2:
                continue

            # Convert points to numpy array for OpenCV
            points_np = np.array(points, dtype=np.int32).reshape((-1, 1, 2))

            # Draw the polyline on the binary image (white)
            cv2.polylines(binary_img, [points_np], isClosed=False, color=255, thickness=5)

            # Calculate the instance gray value
            if num_lanes > 0:
                gray_value = int((num_lanes - idx) * (255 / (num_lanes + 1)))
            else:
                gray_value = 0  # Should not happen as num_lanes is len(lanes)

            # Draw the polyline on the instance image with the calculated gray value
            cv2.polylines(instance_img, [points_np], isClosed=False, color=gray_value, thickness=5)

        # Save the generated images
        cv2.imwrite(str(Path('gt_binary_image') / img_name), binary_img)
        cv2.imwrite(str(Path('gt_instance_image') / img_name), instance_img)

if __name__ == "__main__":
    extract_binary_instance('annotations/annotations.xml')
