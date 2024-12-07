import os
from PIL import Image

# Path to the folder with images
input_folder = "c:/Users/ahmed/Desktop/Welcome day/Welcome day"
output_folder = "C:/Users/ahmed/Desktop/Filterd resized"

# Ensure the output folder exists
os.makedirs(output_folder, exist_ok=True)

# Set the desired resize factor (e.g., 0.5 for 50% size)
resize_factor = 0.5

# Process each image in the folder
for filename in os.listdir(input_folder):
    if filename.lower().endswith(('.png', '.jpg', '.jpeg')):
        # Open the image file
        with Image.open(os.path.join(input_folder, filename)) as img:
            # Calculate new dimensions
            new_dimensions = (int(img.width * resize_factor), int(img.height * resize_factor))
            resized_img = img.resize(new_dimensions, Image.LANCZOS)

            # Save the resized image in the output folder
            resized_img.save(os.path.join(output_folder, filename), quality=85)  # Adjust quality as needed

        print(f"Resized {filename}")

print("All images have been resized.")