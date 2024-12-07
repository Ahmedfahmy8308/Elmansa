import os
from pdf2image import convert_from_path

# Path to the PDF file and Poppler path
pdf_path = r'C:\Users\ahmed\Desktop\w\QR.pdf'
poppler_path = r'C:\poppler\Library\bin'  # Update to your Poppler bin path

# Output folder to save images
output_folder = 'output_images'
os.makedirs(output_folder, exist_ok=True)

# Convert PDF pages to images
images = convert_from_path(pdf_path, poppler_path=poppler_path)

# Save each page as an image with a numbered filename starting from 1
for i, image in enumerate(images):
    # Construct the filename as number (starting from 1)
    image_filename = f"{i + 1}.jpg"  # Numbered from 1
    image_path = os.path.join(output_folder, image_filename)
    image.save(image_path, 'JPEG')
    print(f"Saved {image_path}")
