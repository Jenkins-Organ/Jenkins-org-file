echo "Starting build process..."

if [ -f "hello.py" ]; then
    echo "Found hello.py. No compilation needed for Python."
else
    echo "No source file found!"
    exit 1
fi

echo "Build complete."
