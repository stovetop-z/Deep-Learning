# Project 3: Convolutional Neural Networks (CNNs) in PyTorch

## Overview
This project explores Convolutional Neural Networks (CNNs) for various computer vision tasks. You will implement and train CNNs for image classification, learn about batch normalization and advanced optimizers, build ResNet-style architectures with residual connections, apply transfer learning using pretrained models, and explore object detection and image segmentation.

## Learning Objectives
By completing this project, you will:
1. **Image Classification**: Build CNNs for image classification on CIFAR-10
2. **Batch Normalization & Optimizers**: Understand how batch normalization and advanced optimizers (SGD, Adam) improve training
3. **ResNet & Regularization**: Implement residual blocks and apply regularization techniques (dropout, weight decay)
4. **Transfer Learning**: Fine-tune pretrained CNN models on new datasets (Caltech-UCSD Birds or Caltech-101)
5. **Object Detection**: Use Faster R-CNN for object detection tasks
6. **Image Segmentation**: Implement U-Net for semantic segmentation

## Project Structure
```
project3_student/
├── cnn_fundamentals.ipynb      # Parts 1-4: CNN basics, batch norm, ResNet, regularization
├── transfer_learning.ipynb     # Part 5: Transfer learning with pretrained models
├── object_detection.ipynb      # Part 6: Faster R-CNN for object detection
├── image_segmentation.ipynb    # Part 7: U-Net for image segmentation
├── cpsc8430/                   # Utility modules (REQUIRED)
│   ├── __init__.py
│   └── data_utils.py          # Data loading utilities for all notebooks
├── requirements.txt            # Python dependencies
└── README.md                   # This file
```

**IMPORTANT**: The `cpsc8430/` folder contains the `data_utils.py` module which provides centralized data loading functions used across all notebooks. Make sure to include this folder when uploading to Google Colab or running locally.

## Requirements
- Python 3.8+
- PyTorch 2.0+ and torchvision
- numpy, matplotlib, seaborn
- scikit-learn
- tqdm (for progress bars)
- PIL/Pillow
- jupyter, nbconvert (for PDF export)

## Setup Instructions

### Option 1: Local Conda Environment (Recommended)

1. **Create and activate the environment**
   ```bash
   conda create --name cnn_pytorch_env python=3.10 -y
   conda activate cnn_pytorch_env
   ```

2. **Install PyTorch** (visit https://pytorch.org for your system-specific command)
   ```bash
   # For CPU only
   conda install pytorch torchvision torchaudio cpuonly -c pytorch

   # For CUDA 11.8 (check your CUDA version)
   conda install pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia
   ```

3. **Install project dependencies**
   ```bash
   pip install --upgrade pip setuptools wheel
   pip install -r requirements.txt
   ```

4. *(Optional)* **Register the kernel with Jupyter**
   ```bash
   python -m ipykernel install --user --name cnn_pytorch_env --display-name "CNN PyTorch Env"
   ```

5. **Launch Jupyter** and open the notebooks
   ```bash
   jupyter notebook
   ```

### Option 2: Google Colab

1. **Upload the entire `project3_student/` folder** to Google Drive under `cpsc8430/assignments/`
   - Make sure to include the `cpsc8430/` subfolder with `data_utils.py`
   - Your folder structure should be: `My Drive/cpsc8430/assignments/project3_student/`

2. Open any notebook (e.g., `cnn_fundamentals.ipynb`) in Colab

3. Uncomment and update the Google Drive mounting snippet at the top of the notebook:
   ```python
   from google.colab import drive
   drive.mount('/content/drive')

   FOLDERNAME = 'cpsc8430/assignments/project3_student/'

   import sys
   sys.path.append('/content/drive/My Drive/{}'.format(FOLDERNAME))
   %cd /content/drive/My\ Drive/$FOLDERNAME
   ```

4. Run the cells in order

**IMPORTANT for Colab users**:
- GPU acceleration is highly recommended for this project. Go to Runtime → Change runtime type → Hardware accelerator → GPU.
- Ensure the `cpsc8430/` folder is in the correct location so that `from cpsc8430.data_utils import load_caltech101` works properly.

## Notebooks Overview

### 1. CNN Fundamentals (`cnn_fundamentals.ipynb`)
**Topics Covered:**
- Building basic CNN architectures
- Understanding convolutional, pooling, and fully connected layers
- Batch normalization and its impact on training
- Comparing optimizers (SGD, Adam, AdamW)
- Implementing ResNet with residual connections
- Applying regularization (dropout, weight decay)
- Performance optimization challenge

**Dataset**: Caltech-101 (9,000+ images across 101 categories, resized to 32x32)

**Key Deliverables**:
- Basic CNN implementation
- CNN with batch normalization
- SimpleResNet and RegularizedResNet
- Performance comparison plots
- Achieve ≥56% test accuracy on Caltech-101

**Grading (6 points)**:
- Code quality and implementation: 2 pts
- Performance benchmarks (≥56% accuracy): 2 pts
- Analysis and answers to inline questions: 2 pts

### 2. Transfer Learning (`transfer_learning.ipynb`)
**Topics Covered:**
- Feature extraction vs fine-tuning
- Loading and modifying pretrained models (ResNet, VGG)
- Differential learning rates
- Visualizing learned features
- Comparing with training from scratch

**Dataset**: Caltech-101 (224x224 images for pretrained models)

**Key Deliverables**:
- Feature extraction implementation (frozen conv layers)
- Fine-tuning implementation (all layers trainable)
- Training from scratch comparison
- Differential learning rates experiment
- Feature map visualization

**Grading (6 points)**:
- Code quality and implementation: 2 pts
- Performance benchmarks and analysis: 2 pts
- Analysis and answers to inline questions: 2 pts

### 3. Object Detection (`object_detection.ipynb`)
**Topics Covered:**
- Understanding object detection vs classification
- Faster R-CNN architecture (RPN, RoI pooling, two-stage detection)
- Using pretrained object detection models
- Evaluation metrics (IoU, mAP)
- Non-Maximum Suppression (NMS)
- Feature Pyramid Networks (FPN)

**Dataset**: 5 test images (student-provided) + COCO pretrained model

**Key Deliverables**:
- Pretrained Faster R-CNN inference on test images
- IoU calculation implementation
- Average Precision (AP) calculation
- NMS implementation
- Architecture understanding

**Grading (6 points)**:
- Code quality and implementation: 2 pts
- Performance benchmarks and analysis: 2 pts
- Analysis and answers to inline questions: 2 pts

**Important**: Students must provide 5 test images in `cpsc8430/datasets/test_imgs/` folder

### 4. Image Segmentation (`image_segmentation.ipynb`)
**Topics Covered:**
- Semantic vs instance vs panoptic segmentation
- U-Net encoder-decoder architecture
- Skip connections and upsampling methods
- Segmentation-specific losses (Dice Loss)
- Evaluation metrics (IoU, Dice coefficient)
- Data augmentation for segmentation

**Dataset**: COCO 2017 validation set (500 images subset, 11 classes)

**Key Deliverables**:
- U-Net implementation from scratch (DoubleConv, Down, Up blocks)
- COCO dataset loading and preprocessing
- Dice Loss implementation
- IoU metric implementation
- Training and visualization

**Grading (6 points)**:
- Code quality and implementation: 2 pts
- Performance benchmarks: 2 pts
  - **Minimum**: Test IoU ≥ 0.30 AND Test Dice ≥ 0.35 (required to pass)
  - **Excellent (2.0 pts)**: Test IoU ≥ 0.45 AND Test Dice ≥ 0.50
  - **Good (1.5 pts)**: Test IoU ≥ 0.40 AND Test Dice ≥ 0.45
  - **Satisfactory (1.0 pts)**: Test IoU ≥ 0.35 AND Test Dice ≥ 0.40
  - **Minimum (0.5 pts)**: Test IoU ≥ 0.30 AND Test Dice ≥ 0.35
- Analysis and inline questions: 2 pts

## Grading Criteria

**Overall Project 3: 24 points total**

### Part 1: CNN Fundamentals (6 points)
- Code quality and implementation: 2 pts
- Performance benchmarks (≥56% accuracy on Caltech-101): 2 pts
- Analysis and inline questions: 2 pts

### Part 2: Transfer Learning (6 points)
- Code quality and implementation: 2 pts
- Performance benchmarks and analysis: 2 pts
- Analysis and inline questions: 2 pts

### Part 3: Object Detection (6 points)
- Code quality and implementation: 2 pts
- Performance benchmarks and analysis: 2 pts
- Analysis and inline questions: 2 pts

### Part 4: Image Segmentation (6 points)
- Code quality and implementation: 2 pts
- Performance benchmarks (minimum: IoU ≥0.30, Dice ≥0.35): 2 pts
- Analysis and inline questions: 2 pts

**Note**: Each notebook builds on concepts from previous ones. Complete them in order for best results.

## Dataset Information

### Caltech-101
- **Size**: ~9,000 images across 101 categories
- **Split**: 80% training, 20% test (configured in notebooks)
- **Classes**: 101 object categories + 1 background
- **Download**: Automatic via data_utils.py module
- **Usage**:
  - CNN Fundamentals: Resized to 32x32 for faster training
  - Transfer Learning: Resized to 224x224 for pretrained models
- **Source**: https://data.caltech.edu/records/mzrjq-6wc02

### COCO 2017
- **Size**: 5,000 validation images (subset of 500 used in notebooks)
- **Classes**: 80 object categories (10 used for segmentation)
- **Download**: Automatic in notebooks (~1GB images + ~241MB annotations)
- **Usage**:
  - Image Segmentation: 500 images with segmentation masks
- **Source**: http://cocodataset.org

### Test Images (Object Detection)
- **Requirement**: Students must provide 5 test images
- **Location**: `cpsc8430/datasets/test_imgs/`
- **Formats**: .jpg, .jpeg, .png, .bmp
- **Purpose**: Test pretrained Faster R-CNN model

## Tips for Success

### 1. Start Early
- Each notebook builds on concepts from previous ones
- Allow time for training models (especially transfer learning and segmentation)

### 2. Use GPU Acceleration
- CNNs train much faster on GPU
- Google Colab provides free GPU access
- For local setup, ensure CUDA is properly installed

### 3. Experiment with Hyperparameters
- Learning rate is crucial - try different values
- Batch size affects training speed and memory usage
- Number of epochs - monitor for convergence

### 4. Monitor Training
- Watch for overfitting (train-test gap)
- Use early stopping if test performance plateaus
- Save checkpoints for long training runs

### 5. Understand Before Implementing
- Read the question prompts carefully
- Refer to PyTorch documentation
- Study the architecture diagrams

## Common Issues and Solutions

### Issue: Out of Memory (OOM)
**Solutions:**
- Reduce batch size
- Use mixed precision training (torch.cuda.amp)
- Use smaller model or fewer layers
- Clear GPU cache: `torch.cuda.empty_cache()`

### Issue: Training is Too Slow
**Solutions:**
- Enable GPU acceleration
- Reduce image size
- Use fewer training epochs for experimentation
- Use DataLoader with num_workers > 0

### Issue: Poor Performance
**Solutions:**
- Check data normalization (use ImageNet stats for pretrained models)
- Verify loss is decreasing
- Try different learning rates
- Add data augmentation
- Increase model capacity or train longer

### Issue: Validation Accuracy Not Improving
**Solutions:**
- Check for bugs in evaluation code
- Ensure model is in eval mode: `model.eval()`
- Verify data transforms are correct
- Check for data leakage

## Additional Resources

### PyTorch Documentation
- Main docs: https://pytorch.org/docs/stable/index.html
- Torchvision models: https://pytorch.org/vision/stable/models.html
- Tutorials: https://pytorch.org/tutorials/

### Papers and References
- **ResNet**: "Deep Residual Learning for Image Recognition" (He et al., 2015)
- **Batch Normalization**: "Batch Normalization: Accelerating Deep Network Training" (Ioffe & Szegedy, 2015)
- **Faster R-CNN**: "Faster R-CNN: Towards Real-Time Object Detection" (Ren et al., 2015)
- **U-Net**: "U-Net: Convolutional Networks for Biomedical Image Segmentation" (Ronneberger et al., 2015)

### Datasets
- CIFAR-10: https://www.cs.toronto.edu/~kriz/cifar.html
- Caltech-101: https://data.caltech.edu/records/mzrjq-6wc02
- CUB-200-2011: http://www.vision.caltech.edu/datasets/cub_200_2011/
- Pascal VOC: http://host.robots.ox.ac.uk/pascal/VOC/
- COCO: https://cocodataset.org/

## Submission

### What to Submit
1. **Code**: All completed Jupyter notebooks with outputs
2. **PDF Report**: Exported notebooks showing code, outputs, and answered questions
3. **Summary**: Brief document (1-2 pages) summarizing:
   - Your approach and architectural choices
   - Key findings and performance metrics
   - Challenges faced and solutions

### How to Submit
1. **Complete all notebooks** - Run all cells and ensure outputs are visible
2. **Export to PDF**:
   ```bash
   jupyter nbconvert --to pdf cnn_fundamentals.ipynb
   jupyter nbconvert --to pdf transfer_learning.ipynb
   jupyter nbconvert --to pdf object_detection.ipynb
   jupyter nbconvert --to pdf image_segmentation.ipynb
   ```
3. **Package submissions**:
   ```bash
   zip -r project3_submission.zip project3_student/
   ```
4. **Upload to course submission system** (e.g., Gradescope, Canvas)

### Submission Checklist
- [ ] All TODO sections completed
- [ ] All inline questions answered
- [ ] All notebooks executed with visible outputs
- [ ] Performance requirements met:
  - [ ] Part 1: ≥56% accuracy on Caltech-101
  - [ ] Part 4: IoU ≥0.30 AND Dice ≥0.35
- [ ] 5 test images provided in `cpsc8430/datasets/test_imgs/` (for Part 3)
- [ ] Plots and visualizations included
- [ ] PDFs generated successfully
- [ ] Code is clean and well-commented
- [ ] cpsc8430/ folder with data_utils.py included

## Getting Help

### During Development
- Read error messages carefully
- Check PyTorch documentation
- Use `print()` statements to debug
- Visualize intermediate outputs
- Start with small experiments before full training

### If Stuck
- Review the lecture materials
- Check the HINT comments in TODO sections
- Refer to the architecture diagrams
- Search PyTorch forums and Stack Overflow
- Ask on course discussion board
- Attend office hours

## Academic Integrity
- Write your own code - do not copy from others
- You may use PyTorch documentation and official tutorials
- Cite any external code or resources you use
- Collaboration on concepts is OK, but implementations must be individual
- Do not share your code with other students

---

**Good luck with your CNN project! Remember, the goal is not just to complete the tasks, but to deeply understand how CNNs work and why they're so effective for computer vision.**
