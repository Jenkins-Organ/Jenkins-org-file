echo "Starting test process..."

if python3 -m unittest discover tests; then
    echo "All tests passed."
else
    echo "Tests failed!"
    exit 1
fi
