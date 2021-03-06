#!/bin/sh

echo "OL FONTS INSTALLATION SCRIPT"
echo "This bash script copies the OL font files to your LaTeX user folder. You may be prompted for your system password to enable copying."

# Use the inbuilt kpsewhich function to hunt down the system texmf directory
echo "Detecting TeX directory..."
TEXDIR=`kpsewhich -var-value=TEXMFHOME`

# Check to make sure that TEXDIR is set before copying
if [[ -z $TEXDIR ]]
then
  echo "No TeX directory detected. Unable to proceed. Exiting..."
  exit 1
else
  # Set up the ../tex/latex file-path if it doesn't already exist
  if [[ ! -d "$TEXDIR/tex/latex" ]]
    then
      echo "Creating file-paths..."
      sudo mkdir -p $TEXDIR/tex/latex
  fi

  # Recursively copy the appropriate directories in the current directory to the system directory
  echo "Copying files..."
  sudo cp -R -p ${0%/*}/bigdaddy $TEXDIR/tex/latex/
  echo "Copying bigdaddy..."

  echo "Done!"
fi

echo "Rehashing TeX packages so the system sees the new package"
sudo texhash

echo "Installation successful. You can now put \usepackage{bigdaddy} in your preamble and enjoy."