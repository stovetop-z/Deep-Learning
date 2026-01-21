# Project 1 Starter Package - Student Version

This folder contains all the necessary files for students to complete Project 1: Linear Feature Classifier and Softmax Implementation.

## 📁 **Package Contents**

### **Main Project Files**
- `01_linear_feature.ipynb` - Main project notebook for linear feature classification
- `02_softmax.ipynb` - Second project notebook for softmax implementation
- `README.md` - Complete project instructions and setup guide

### **Submission Tools**
- `collectSubmission.sh` - Automated submission script for local environment
- `collect_submission.ipynb` - Google Colab submission notebook
- `makepdf.py` - PDF generation and merging script

### **Core Project Code**
- `cpsc8430/` - Main project package
  - `data_utils.py` - Data loading and preprocessing utilities
  - `classifiers/linear_classifier.py` - Linear classifier implementation
  - `datasets/` - MNIST dataset and setup scripts

### **Dependencies & Configuration**
- `requirements.txt` - Python package dependencies
- `all_weights_combined.png` - Sample weight template image
- `all_weights_combined_learned.png` - Sample learned weights image

## 🚀 **Getting Started**

1. **Install Dependencies**: `pip install -r requirements.txt`
2. **Download MNIST**: Run `bash cpsc8430/datasets/get_datasets.sh`
3. **Complete Notebooks**: Work through `01_linear_feature.ipynb` and `02_softmax.ipynb`
4. **Generate Submission**: Use `collectSubmission.sh` or `collect_submission.ipynb`

## 📊 **Project Structure**

```
Project 1/
├── 01_linear_feature.ipynb          # Linear feature classifier (5 points)
├── 02_softmax.ipynb                 # Softmax implementation (5 points)
├── README.md                         # Project instructions
├── requirements.txt                  # Python dependencies
├── collectSubmission.sh              # Local submission script
├── collect_submission.ipynb          # Colab submission notebook
├── makepdf.py                       # PDF generation script
└── cpsc8430/                        # Core project code
    ├── __init__.py
    ├── data_utils.py                 # Data utilities
    ├── classifiers/
    │   ├── __init__.py
    │   └── linear_classifier.py      # Linear classifier code
    └── datasets/
        ├── get_datasets.sh           # Dataset setup script
        └── MNIST/                    # MNIST dataset files
```

## 🎯 **Learning Objectives**

- **Linear Feature Classifier**: Implement and train a linear classifier using pre-defined weight templates
- **Softmax Implementation**: Build and train a softmax classifier from scratch
- **Image Processing**: Work with MNIST digit images and weight visualizations
- **Machine Learning**: Understand linear classification, gradient descent, and softmax regression

## 📝 **Submission Requirements**

- **Code Submission**: ZIP file containing all notebooks and code
- **PDF Report**: Single merged PDF of both notebooks
- **Generated Images**: `all_weights_combined_(YOUR CUID).png` and `all_weights_combined_learned.png`

## 🔗 **Resources**

- **Weight Template Generator**: https://nianyi-li.github.io/CPSC-6430-fall25/P1_GUI/
- **Project Documentation**: See README.md for detailed instructions
- **Submission Help**: Use the provided submission scripts for automated file generation

---
*This starter package contains only the essential files needed for students to complete the project. Instructor solutions and internal documentation are not included.*


