"""
Linear Classifier implementation based on visual templates
Extracted from 01_linear_feature.ipynb for reuse in other notebooks
"""

import torch
import torchvision
import numpy as np
from PIL import Image


def load_and_preprocess_image(image_path, eta=0.0):
    """
    Load and preprocess a combined digits image
    
    Args:
        image_path: Path to the combined digits image
        alpha: Grayscale inversion parameter (0.0 = original, 1.0 = fully inverted)
    
    Returns:
        img_normalized: Normalized image tensor of shape (280, 28)
    """
    # Load the image
    img = Image.open(image_path)
    img_array = np.array(img)

    alpha = eta
    
    # Convert to grayscale if image is RGB
    if len(img_array.shape) == 3:
        img_array = img_array.mean(axis=2)
    
    # Apply alpha adjustment for grayscale inversion
    img_modified = (1 - alpha) * img_array + alpha * (255 - img_array)
    
    # Resize to height 280 and width 28 (10 blocks of 28x28 stacked vertically)
    target_size = (28, 280)  # Note: PIL uses (width, height)
    img_resized = Image.fromarray(img_modified.astype(np.uint8)).resize(target_size)
    img_tensor = torch.tensor(np.array(img_resized), dtype=torch.float32)
    
    # Normalize to [-1, 1]
    img_min = img_tensor.min()
    img_max = img_tensor.max()
    img_normalized = 2.0 * (img_tensor - img_min) / (img_max - img_min) - 1.0
    
    return img_normalized


def create_weight_matrix(img_normalized):
    """
    Create weight matrix [10, 784] from the normalized image
    
    Args:
        img_normalized: Normalized image tensor of shape (280, 28)
    
    Returns:
        weight_matrix: Weight matrix of shape (10, 784)
    """
    weight_matrix = torch.zeros(10, 784)
    
    # The image is 280x28, which means we have 10 blocks of 28x28 stacked vertically
    for i in range(10):
        # Extract the i-th 28x28 block (vertically stacked)
        start_row = i * 28
        end_row = start_row + 28
        block = img_normalized[start_row:end_row, :]
        
        # Flatten the block and assign to the corresponding row in weight matrix
        weight_matrix[i] = block.flatten()
    
    return weight_matrix


def create_mnist_test_loader(batch_size=1000):
    """
    Create MNIST test dataset loader
    
    Args:
        batch_size: Batch size for testing
    
    Returns:
        test_loader: DataLoader for MNIST test dataset
    """
    transform = torchvision.transforms.Compose([
        torchvision.transforms.ToTensor(),
        torchvision.transforms.Normalize((0.1307,), (0.3081,))  # MNIST mean and std
    ])
    
    test_dataset = torchvision.datasets.MNIST(
        root='cpsc8430/datasets/MNIST',
        train=False,
        download=True,
        transform=transform
    )
    
    test_loader = torch.utils.data.DataLoader(
        test_dataset,
        batch_size=batch_size,
        shuffle=False
    )
    
    return test_loader


def evaluate_linear_classifier(weight_matrix, bias, test_loader):
    """
    Evaluate the linear classifier on MNIST test dataset
    
    Args:
        weight_matrix: Weight matrix of shape (10, 784)
        bias: Bias vector of shape (10,)
        test_loader: DataLoader for test dataset
    
    Returns:
        accuracy: Test accuracy percentage
    """
    correct = 0
    total = 0
    
    with torch.no_grad():
        for images, labels in test_loader:
            # Flatten the images
            images = images.view(-1, 784)
            
            # Forward pass: compute scores
            scores = torch.mm(images, weight_matrix.t()) + bias
            
            # Get predictions
            _, predicted = torch.max(scores, 1)
            
            # Update statistics
            total += labels.size(0)
            correct += (predicted == labels).sum().item()
    
    return 100 * correct / total


def create_random_bias():
    """
    Create random bias vector for the linear classifier
    
    Returns:
        bias: Random bias vector of shape (10,)
    """
    return torch.randn(10)


def process_image_and_evaluate(image_path, alpha=0.0, bias=None):
    """
    Complete pipeline: load image, create weights, and evaluate
    
    Args:
        image_path: Path to the combined digits image
        alpha: Grayscale inversion parameter
        bias: Bias vector (if None, creates random bias)
    
    Returns:
        accuracy: Test accuracy percentage
        weight_matrix: Created weight matrix
        bias: Used bias vector
    """
    # Load and preprocess image
    img_normalized = load_and_preprocess_image(image_path, alpha)
    
    # Create weight matrix
    weight_matrix = create_weight_matrix(img_normalized)
    
    # Create test loader
    test_loader = create_mnist_test_loader()
    
    # Create bias if not provided
    if bias is None:
        bias = create_random_bias()
    
    # Evaluate classifier
    accuracy = evaluate_linear_classifier(weight_matrix, bias, test_loader)
    
    return accuracy, weight_matrix, bias
