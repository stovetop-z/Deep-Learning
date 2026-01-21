# Project 1: MNIST Linear Classifier

## Overview
This project implements a linear classifier for the MNIST dataset using visual templates. Students will learn to:
- Create a linear classifier from a combined weights image
- Implement softmax activation and use PyTorch's automatic differentiation
- Preprocess image data for machine learning
- Work with PyTorch and the MNIST dataset
- Achieve test accuracy greater than 20% (Linear Feature) and 90% (Softmax)

## Project Structure
```
Project 1/
├── 01_linear_feature.ipynb          # Linear Feature Classifier (50% of project score)
├── 02_softmax.ipynb                 # Softmax Implementation (50% of project score)
├── cpsc8430/                      # Main package directory
│   ├── __init__.py                # Package initialization
│   ├── data_utils.py              # Data loading utilities
│   ├── classifiers/               # Classifier implementations
│   │   └── __init__.py
│   └── datasets/                  # Dataset directory
│       └── get_datasets.sh        # Dataset setup script
├── collect_submission.ipynb       # Submission collection notebook (Google Colab)
├── collectSubmission.sh     # Enhanced submission script ⭐
├── makepdf.py                     # PDF generation and merging script
└── README.md                      # This file
```


## Requirements
- Python 3.7+
- PyTorch
- torchvision
- numpy
- matplotlib
- PIL (Pillow)
- Jupyter Notebook or Google Colab

## Setup Instructions

### Option 1: Local Environment (Recommended)

#### Prerequisites Installation
1. **Install Python Dependencies:**
   ```bash
   pip install torch torchvision numpy matplotlib pillow jupyter nbconvert
   ```

2. **Install LaTeX for PDF Generation (macOS):**
   ```bash
   # Install Homebrew if you don't have it
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   
   # Install Pandoc and BasicTeX
   brew install pandoc
   brew install --cask basictex
   
   # Update PATH (restart terminal or run this command)
   eval "$(/usr/libexec/path_helper)"
   
   # Install required LaTeX packages
   sudo tlmgr update --self
   sudo tlmgr install tcolorbox pdfcol adjustbox titling enumitem rsfs
   ```

3. **Install LaTeX for PDF Generation (Ubuntu/Debian):**
   ```bash
   sudo apt-get update
   sudo apt-get install texlive-xetex texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra
   sudo apt-get install pandoc
   ```

4. **Install LaTeX for PDF Generation (Windows):**
   - Download and install MiKTeX from: https://miktex.org/download
   - Download and install Pandoc from: https://pandoc.org/installing.html

#### Local Setup
1. Clone or download the project folder to your local machine
2. Open terminal/command prompt and navigate to the project directory
3. Install Python dependencies: `pip install -r requirements.txt`
4. Open `01_linear_feature.ipynb` in Jupyter Notebook or VS Code
5. Run the notebook cells in order

### Option 2: Google Colab
1. Upload the project folder to Google Drive
2. Open `01_linear_feature.ipynb` in Google Colab
3. **Uncomment the Google Colab setup section at the top of the notebook**
4. Update the `FOLDERNAME` variable to point to your project location
5. Run the notebook cells in order

**Note:** Each notebook includes Google Colab setup code at the beginning that can be easily commented out for local computer running.

## Grading Criteria

### 01_linear_feature.ipynb (50% of project score)
- Test accuracy must be >20% (60% points)
- Code quality and implementation (8% points)
- Analysis and answers to questions (32% points)
- **Total: 5 points**

### 02_softmax.ipynb (50% of project score)
- Test accuracy must be >90% (60% points)
- Code quality and implementation (10% points)
- Analysis and answers to questions (30% points)
- **Total: 5 points**

**Overall Project Total: 10 points**

## Image Requirements

**Important**: You need to provide your own combined weights image named `all_weights_combined_(YOUR CUID).png` in the Project 1 folder. This image should contain all 10 weight templates stacked vertically, with each template being approximately 28x28 pixels when resized.

### Weight Template Generator:
You can use this temporary website to generate and download your image:  
[https://nianyi-li.github.io/CPSC-6430-fall25/P1_GUI/](https://nianyi-li.github.io/CPSC-6430-fall25/P1_GUI/)

After downloading, rename your file as instructed, `all_weights_combined_(YOUR CUID).png`, and place it in the Project 1 folder.

## Submission

### For Local Environment:
1. Complete the `01_linear_feature.ipynb` notebook
2. Complete the `02_softmax.ipynb` notebook
3. Option A: (Not recommended) Run `collect_submission_local.ipynb` in Jupyter 
4. **Option B:** Use terminal command: `bash collectSubmission.sh` (faster, more reliable)
5. Submit both files to Gradescope:
   - `project1_code_submission.zip` (code submission)
   - `project1_inline_submission.pdf` (merged PDF of all notebooks)
6. **Include your generated image file**: `all_weights_combined_(YOUR CUID).png`

**💡 Pro Tip:** If you encounter PDF generation issues in Jupyter, try the terminal command instead - it often works better and provides clearer error messages!

### For Google Colab:
1. Complete the `01_linear_feature.ipynb` notebook
2. Complete the `02_softmax.ipynb` notebook
3. Run `collect_submission.ipynb` to generate submission files
3. Submit both `project1_code_submission.zip` and `project1_inline_submission.pdf` to Gradescope
4. **Include your generated image file**: `all_weights_combined_(YOUR CUID).png`

**NEW:** The enhanced scripts automatically merge multiple PDFs into one file, exactly like the original assignment!

## Troubleshooting

### PDF Generation Issues
- **"Pandoc not found"**: Install Pandoc using the instructions above
- **"xelatex not found"**: Install BasicTeX/MiKTeX using the instructions above
- **Missing LaTeX packages**: Run the `tlmgr install` commands listed above

### Common Errors
- **ModuleNotFoundError**: Ensure all Python packages are installed: `pip install -r requirements.txt`
- **Permission denied**: Use `sudo` for LaTeX package installation on macOS/Linux
- **Font not found**: Install the `rsfs` package: `sudo tlmgr install rsfs`

## Enhanced Local Submission Features

### 🚀 What's New in Local Environment
- **Automatic PDF Merging**: The enhanced scripts automatically merge multiple notebook PDFs into a single `project1_inline_submission.pdf` file
- **Identical Output**: Generates exactly the same files and format as the original `collect_submission.ipynb`
- **Smart Fallbacks**: If PDF merging fails, provides helpful error messages and alternative options
- **Tool Validation**: Automatically checks if required tools (Pandoc, LaTeX, PyPDF2) are installed

### 📁 Files Generated
When using the enhanced local submission tools, you'll get:
1. **`project1_code_submission.zip`** - Contains all your code, notebooks, and generated image files (including `all_weights_combined_*.png`)
2. **`project1_inline_submission.pdf`** - **Single merged PDF** of all notebooks (not multiple individual PDFs)

This matches the **exact format** expected by Gradescope and the original assignment!

## 🖥️ **Local Terminal Usage (Alternative Method)**

If you prefer to use the terminal directly instead of Jupyter notebooks, you can generate all submission files using a single command:

### **Quick Terminal Command:**
```bash
# Navigate to your project directory first
cd /path/to/your/Project\ 1

# Run the submission script directly
bash collectSubmission.sh
```

### **What This Command Does:**
1. **Automatically checks** your environment and dependencies
2. **Creates** `project1_code_submission.zip` with all your code
3. **Converts** both notebooks to PDF format
4. **Merges** all PDFs into a single `project1_inline_submission.pdf`
5. **Provides** detailed status and error messages

### **Prerequisites for Terminal Usage:**
- **macOS**: Install dependencies with `bash install_dependencies.sh`
- **Ubuntu/Debian**: Install dependencies with `bash install_dependencies.sh`
- **Windows**: Install MiKTeX and Pandoc manually (see setup instructions above)

### **Benefits of Terminal Usage:**
- **Faster execution** - No Jupyter overhead
- **Better error visibility** - See all output in real-time
- **Automated dependency checking** - Script tells you what's missing
- **Consistent results** - Same output every time

### **Troubleshooting Terminal Issues:**
- **Permission denied**: Make sure the script is executable: `chmod +x collectSubmission.sh`
- **Command not found**: Ensure you're in the correct project directory
- **Dependencies missing**: Run `bash install_dependencies.sh` first

## Auto-Grading
This project is designed to be compatible with Gradescope's auto-grader. The test cells with metadata `"test": "test_accuracy"` will be automatically executed to verify the minimum accuracy requirements:
- `01_linear_feature.ipynb`: >20% accuracy
- `02_softmax.ipynb`: >90% accuracy
