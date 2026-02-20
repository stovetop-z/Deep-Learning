# Project 2: Multi-Layer Perceptrons (MLPs) in PyTorch

## Overview
This project introduces Multi-Layer Perceptrons (MLPs) using PyTorch. You will:
- Build configurable MLP architectures with PyTorch modules
- Explore the impact of activation functions, learning rates, and optimizers
- Study overfitting vs. underfitting by varying model capacity
- Visualize learned weights and evaluate cross-domain performance on USPS digits
- Document best hyperparameters that generalize from MNIST to USPS

## Project Structure
```
project2/
├── mlp.ipynb               # Student starter notebook
├── collectSubmission.sh    # Script to package code + PDF submissions
├── collect_submission.ipynb# Optional Colab packaging notebook
├── requirements.txt        # Python dependencies
└── README.md               # This file
```

## Requirements
- Python 3.8+
- PyTorch 2.x and torchvision
- numpy, matplotlib, seaborn
- scikit-learn
- jupyter, nbconvert (for PDF export)
- LaTeX toolchain (xelatex) if generating PDFs locally

## Setup Instructions

### Option 1: Local Conda Environment (Recommended)
1. **Create and activate the environment**
   ```bash
   conda create --name mlp_pytorch_env python=3.10 -y
   conda activate mlp_pytorch_env
   ```
2. **Install project dependencies**
   ```bash
   pip install --upgrade pip setuptools wheel
   pip install -r requirements.txt
   ```
3. *(Optional)* **Register the kernel with Jupyter**
   ```bash
   python -m ipykernel install --user --name mlp_pytorch_env --display-name "MLP PyTorch Env"
   ```
4. **Launch Jupyter** and open `mlp.ipynb`

### Option 2: Google Colab
1. Upload the `project2/` folder to Google Drive `cpsc8430/assignments/`
2. Open `mlp.ipynb` in Colab
3. Uncomment and update the Google Drive mounting snippet at the top of the notebook
4. Run the cells in order

## Grading Criteria
- Implementation quality and correctness (3 pts)
- Testing performance and parameter adjustment (5 pts)
- Analysis and responses to inline questions (4 pts)
- **Total: 12 points**

## Submission

### Local Environment
1. Complete all tasks in `mlp.ipynb`
2. From the project directory, run:
   ```bash
   bash collectSubmission.sh
   ```
3. The script produces:
   - `project2_code_submission.zip`
   - `project2_inline_submission.pdf` (or `project2_inline_submission.html` if manual PDF conversion is required)
4. If the PDF is missing and only the HTML file is produced, open the HTML in your browser and use **Print → Save as PDF** to create `project2_inline_submission.pdf`.
5. Upload both artifacts to Gradescope once the PDF is ready.

### Google Colab
1. Complete `mlp.ipynb`
2. Run `collect_submission.ipynb` to mirror the local packaging steps
3. Download and submit the generated ZIP and PDF files to Gradescope

Ensure the notebook is fully executed and that all visualizations/analyses are visible in the exported PDF.
