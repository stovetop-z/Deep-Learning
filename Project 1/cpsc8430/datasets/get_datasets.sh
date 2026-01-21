#!/bin/bash
# Download MNIST dataset and create combined digits image

echo "Setting up datasets for Project 1..."

# Create datasets directory if it doesn't exist
mkdir -p mnist

# Download MNIST dataset (will be handled by PyTorch)
echo "MNIST dataset will be downloaded automatically when running the notebook."

# Create a sample combined digits image if it doesn't exist
if [ ! -f "all_digits_combined_1_2.png" ]; then
    echo "Creating sample combined digits image..."
    # This is a placeholder - in practice, students would provide their own image
    echo "Please provide your own combined digits image named 'all_digits_combined_1_2.png'"
    echo "The image should contain all 10 digits (0-9) stacked vertically."
    echo "Each digit should be approximately 28x28 pixels when resized."
fi

echo "Dataset setup complete!"
