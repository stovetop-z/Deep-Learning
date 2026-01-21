#!/bin/bash
# Enhanced submission script for Project 1 (Local Version)
# This script provides the same functionality as collectSubmission.sh
# Run the submission script directly
# bash collectSubmission.sh
set -euo pipefail

# Configuration - Match the original collectSubmission.sh exactly
CODE=(
	"cpsc8430/data_utils.py"
)

# these notebooks should ideally
# be in order of questions so
# that the generated pdf is
# in order of questions
NOTEBOOKS=(
	"01_linear_feature.ipynb"
	"02_softmax.ipynb"
)

FILES=( "${CODE[@]}" "${NOTEBOOKS[@]}" )
LOCAL_DIR=`pwd`
ASSIGNMENT_NO=1
ZIP_FILENAME="project1_code_submission.zip"
PDF_FILENAME="project1_inline_submission.pdf"

# Colors for output
C_R="\e[31m"
C_G="\e[32m"
C_Y="\e[33m"
C_B="\e[34m"
C_BLD="\e[1m"
C_E="\e[0m"

echo -e "${C_BLD}Project 1 Submission Script (Local Version)${C_E}"
echo "=================================================="

# Function to check if a tool is available
check_tool() {
    local tool_name="$1"
    local install_command="$2"
    
    if command -v "$tool_name" >/dev/null 2>&1; then
        echo -e "${C_G}✅ $tool_name is available${C_E}"
        return 0
    else
        echo -e "${C_R}❌ $tool_name is not installed${C_E}"
        echo -e "   Install with: $install_command"
        return 1
    fi
}

# Function to check if a file exists
check_file() {
    local file="$1"
    if [ -f "$file" ]; then
        echo -e "${C_G}✓ Found $file${C_E}"
        return 0
    else
        echo -e "${C_R}✗ File $file not found${C_E}"
        return 1
    fi
}

# Main execution
echo -e "\n${C_BLD}=== Environment Check ===${C_E}"
echo "Current working directory: $(pwd)"
echo "Python version: $(python3 --version 2>/dev/null || echo 'Python3 not found')"

echo -e "\n${C_BLD}=== Checking Required Tools ===${C_E}"
pandoc_available=false
xelatex_available=false
jupyter_available=false

if check_tool "pandoc" "brew install pandoc (macOS) or sudo apt-get install pandoc (Ubuntu)"; then
    pandoc_available=true
fi

if check_tool "xelatex" "brew install --cask basictex (macOS) or sudo apt-get install texlive-xetex (Ubuntu)"; then
    xelatex_available=true
fi

if check_tool "jupyter" "pip install jupyter"; then
    jupyter_available=true
fi

# Check if PyPDF2 is available
echo -e "\n${C_BLD}=== Checking Python Dependencies ===${C_E}"
PYTHON_CMD="python3"
if python -c "import PyPDF2" 2>/dev/null; then
    echo -e "${C_G}✅ PyPDF2 is available in conda environment${C_E}"
    PYTHON_CMD="python"
elif python3 -c "import PyPDF2" 2>/dev/null; then
    echo -e "${C_G}✅ PyPDF2 is available in system Python${C_E}"
    PYTHON_CMD="python3"
else
    echo -e "${C_R}❌ PyPDF2 is not available${C_E}"
    echo -e "   Install with: pip install PyPDF2"
    echo -e "   This is required for PDF merging"
fi

echo -e "\n${C_BLD}=== Checking Required Files ===${C_E}"
all_files_exist=true
for FILE in "${FILES[@]}"; do
    if ! check_file "$FILE"; then
        all_files_exist=false
    fi
done

if [ "$all_files_exist" = false ]; then
    echo -e "\n${C_R}Some required files are missing. Please check the errors above.${C_E}"
    exit 1
fi

echo -e "\n${C_BLD}### Zipping file ###${C_E}"
rm -f "${ZIP_FILENAME}"
zip -q "${ZIP_FILENAME}" -r ${NOTEBOOKS[@]} $(find . -name "*.py") "cpsc8430/saved" $(find . -name "*.png") -x "makepdf.py"

if [ -f "${ZIP_FILENAME}" ]; then
    echo -e "${C_G}✅ Created ${ZIP_FILENAME}${C_E}"
else
    echo -e "${C_R}❌ Failed to create ZIP file${C_E}"
    exit 1
fi

echo -e "\n${C_BLD}### Creating PDFs ===${C_E}"

# First, convert individual notebooks to PDF using multiple methods
echo "Converting notebooks to individual PDFs..."
conversion_success_count=0

for notebook in "${NOTEBOOKS[@]}"; do
    if [ -f "$notebook" ]; then
        echo "Converting $notebook to PDF..."
        pdf_name="${notebook%.ipynb}.pdf"
        conversion_success=false
        
        # Method 1: Try jupyter nbconvert with HTML first, then convert to PDF
        if command -v "jupyter" >/dev/null 2>&1; then
            echo "  Trying jupyter nbconvert --to html..."
            if jupyter nbconvert --to html "$notebook" --output-dir . >/dev/null 2>&1; then
                html_name="${notebook%.ipynb}.html"
                if [ -f "$html_name" ]; then
                    echo "  HTML created successfully, converting to PDF..."
                    
                    # Try pandoc to convert HTML to PDF
                    if command -v "pandoc" >/dev/null 2>&1; then
                        if pandoc "$html_name" -o "$pdf_name" >/dev/null 2>&1; then
                            echo -e "${C_G}✅ $notebook converted to PDF using HTML + pandoc method${C_E}"
                            conversion_success=true
                            conversion_success_count=$((conversion_success_count + 1))
                            rm -f "$html_name"  # Clean up HTML file
                        else
                            echo "  ❌ pandoc conversion failed"
                        fi
                    else
                        echo "  ❌ pandoc not available"
                    fi
                    
                    if [ "$conversion_success" = false ]; then
                        rm -f "$html_name"  # Clean up HTML file
                    fi
                fi
            fi
        fi
        
        # Method 2: Try direct jupyter nbconvert to PDF (if Method 1 failed)
        if [ "$conversion_success" = false ] && command -v "jupyter" >/dev/null 2>&1; then
            echo "  Trying jupyter nbconvert --to pdf..."
            if jupyter nbconvert --to pdf "$notebook" >/dev/null 2>&1; then
                if [ -f "$pdf_name" ]; then
                    echo -e "${C_G}✅ $notebook converted to PDF using direct method${C_E}"
                    conversion_success=true
                    conversion_success_count=$((conversion_success_count + 1))
                fi
            fi
        fi
        
        # Method 3: Try pandoc directly (if previous methods failed)
        if [ "$conversion_success" = false ] && command -v "pandoc" >/dev/null 2>&1; then
            echo "  Trying pandoc direct conversion..."
            if pandoc "$notebook" -o "$pdf_name" >/dev/null 2>&1; then
                if [ -f "$pdf_name" ]; then
                    echo -e "${C_G}✅ $notebook converted to PDF using pandoc direct method${C_E}"
                    conversion_success=true
                    conversion_success_count=$((conversion_success_count + 1))
                fi
            fi
        fi
        
        if [ "$conversion_success" = false ]; then
            echo -e "${C_R}❌ Failed to convert $notebook to PDF using all methods${C_E}"
        fi
    else
        echo -e "${C_Y}⚠️  $notebook not found, skipping${C_E}"
    fi
done

echo -e "\n${C_G}Successfully converted $conversion_success_count out of ${#NOTEBOOKS[@]} notebooks to PDF${C_E}"

# Now merge PDFs using makepdf.py (matching original behavior)
echo -e "\nMerging PDFs into single file..."

if [ $conversion_success_count -eq 0 ]; then
    echo -e "${C_R}❌ No notebooks were successfully converted to PDF${C_E}"
    echo -e "${C_Y}⚠️  Cannot create merged PDF without individual PDFs${C_E}"
    echo -e "${C_B}Suggestions:${C_E}"
    echo -e "1. Install dependencies: bash install_dependencies.sh"
    echo -e "2. Check if PyPDF2 is installed: pip install PyPDF2"
    echo -e "3. Try manual conversion: jupyter nbconvert --to html *.ipynb && pandoc *.html -o combined.pdf"
else
    if [ -f "makepdf.py" ]; then
        echo "Using makepdf.py to merge PDFs..."
        if $PYTHON_CMD makepdf.py --notebooks "${NOTEBOOKS[@]}" --pdf_filename "${PDF_FILENAME}" >/dev/null 2>&1; then
            if [ -f "${PDF_FILENAME}" ]; then
                echo -e "${C_G}✅ Successfully created merged PDF: ${PDF_FILENAME}${C_E}"
            else
                echo -e "${C_Y}⚠️  makepdf.py ran but ${PDF_FILENAME} not found${C_E}"
                echo "This might be due to missing PyPDF2 or other dependencies"
            fi
        else
            echo -e "${C_Y}⚠️  makepdf.py failed, trying manual PDF creation${C_E}"
            # Fallback: if makepdf.py fails, just use the first PDF
            first_pdf=""
            for notebook in "${NOTEBOOKS[@]}"; do
                pdf_name="${notebook%.ipynb}.pdf"
                if [ -f "$pdf_name" ]; then
                    first_pdf="$pdf_name"
                    break
                fi
            done
            
            if [ -n "$first_pdf" ]; then
                cp "$first_pdf" "${PDF_FILENAME}"
                echo -e "${C_G}✅ Created ${PDF_FILENAME} from $first_pdf${C_E}"
            else
                echo -e "${C_R}❌ No PDF files found to merge${C_E}"
            fi
        fi
    else
        echo -e "${C_R}❌ makepdf.py not found${C_E}"
        echo "This script is required for PDF merging"
        exit 1
    fi
fi

echo -e "\n${C_BLD}### Final Status ===${C_E}"
submission_files=()

if [ -f "${ZIP_FILENAME}" ]; then
    submission_files+=("${ZIP_FILENAME}")
    echo -e "${C_G}✅ ${ZIP_FILENAME} - Ready for submission${C_E}"
fi

if [ -f "${PDF_FILENAME}" ]; then
    submission_files+=("${PDF_FILENAME}")
    echo -e "${C_G}✅ ${PDF_FILENAME} - Ready for submission${C_E}"
else
    echo -e "${C_R}❌ ${PDF_FILENAME} - Not created${C_E}"
fi

# Final instructions - Updated to include all three required files
echo -e "\n${C_BLD}### Done! Please submit ${ZIP_FILENAME}, ${PDF_FILENAME}, and all generated PNG files to Gradescope. ###${C_E}"
echo -e "\n${C_B}Required submission files:${C_E}"
echo -e "1. ${C_G}${ZIP_FILENAME}${C_E} - Code submission (ZIP file)"
echo -e "2. ${C_G}${PDF_FILENAME}${C_E} - Notebook submission (merged PDF)"
echo -e "3. ${C_G}All generated PNG files${C_E} - Generated image files (including all_weights_combined*.png)"
echo -e "\nNote: Each notebook is worth 5 points (50% of the total 10-point project score)."

echo -e "\n${C_BLD}=== Summary ===${C_E}"
echo "ZIP file: ${ZIP_FILENAME}"
echo "Merged PDF: ${PDF_FILENAME}"
echo "Total submission files: ${#submission_files[@]}"
echo -e "\nScript completed successfully! 🎉"
