import os
import pickle
import numpy as np
from PIL import Image
import torch
import torchvision

def load_MNIST(data_dir):
    """
    Load the MNIST dataset.
    
    Args:
        data_dir: Directory containing the MNIST data
        
    Returns:
        X_train: Training data
        y_train: Training labels  
        X_test: Test data
        y_test: Test labels
    """
    
    # Check if data directory exists
    if not os.path.exists(data_dir):
        os.makedirs(data_dir)
    
    # Download MNIST if not already present
    transform = torchvision.transforms.Compose([
        torchvision.transforms.ToTensor(),
    ])
    
    # Load training data
    train_dataset = torchvision.datasets.MNIST(
        root=data_dir,
        train=True,
        download=True,
        transform=transform
    )
    
    # Load test data
    test_dataset = torchvision.datasets.MNIST(
        root=data_dir,
        train=False,
        download=True,
        transform=transform
    )
    
    # Convert to numpy arrays
    X_train = []
    y_train = []
    for i in range(len(train_dataset)):
        img, label = train_dataset[i]
        X_train.append(img.numpy())
        y_train.append(label)
    
    X_test = []
    y_test = []
    for i in range(len(test_dataset)):
        img, label = test_dataset[i]
        X_test.append(img.numpy())
        y_test.append(label)
    
    # Convert to numpy arrays
    X_train = np.array(X_train)
    y_train = np.array(y_train)
    X_test = np.array(X_test)
    y_test = np.array(y_test)
    
    # Convert to uint8 format for visualization
    X_train = (X_train * 255).astype(np.uint8)
    X_test = (X_test * 255).astype(np.uint8)
    
    return X_train, y_train, X_test, y_test

def get_MNIST_data(num_training=5000, num_validation=500, num_test=500):
    """
    Load the MNIST dataset and perform preprocessing to prepare
    it for the linear classifier.
    
    Args:
        num_training: Number of training samples
        num_validation: Number of validation samples  
        num_test: Number of test samples
        
    Returns:
        X_train: Training data
        y_train: Training labels
        X_val: Validation data
        y_val: Validation labels
        X_test: Test data
        y_test: Test labels
    """
    
    # Load the raw MNIST data
    mnist_dir = 'cpsc8430/datasets/mnist'
    
    # Cleaning up variables to prevent loading data multiple times (which may cause memory issue)
    try:
       del X_train, y_train
       del X_test, y_test
       print('Clear previously loaded data.')
    except:
       pass
    
    X_train, y_train, X_test, y_test = load_MNIST(mnist_dir)
    
    # Subsample the data
    mask = list(range(num_training, num_training + num_validation))
    X_val = X_train[mask]
    y_val = y_train[mask]
    mask = list(range(num_training))
    X_train = X_train[mask]
    y_train = y_train[mask]
    mask = list(range(num_test))
    X_test = X_test[mask]
    y_test = y_test[mask]
    
    return X_train, y_train, X_val, y_val, X_test, y_test
