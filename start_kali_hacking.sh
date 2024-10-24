#!/bin/bash

python3.11 -m venv haKC_Kali
source haKC_Kali/bin/activate
haKC_Kali/bin/python -m pip install --upgrade -q pip
haKC_Kali/bin/python -m pip install -q -r kali/dev-requirements.txt

if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
else
    echo "Error: .env file not found"
    exit 1
fi

if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo "Error: ANTHROPIC_API_KEY not found in .env file"
    exit 1
fi

cd kali

docker run \
    -e ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" \
    -v $(pwd):/home/hakcer/app \
    -p 5900:5900 \
    -p 8501:8501 \
    -p 6080:6080 \
    -p 8080:8080 \
    --name hakc-kali \
    -it hakc-kali-image
