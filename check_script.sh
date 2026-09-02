#!/bin/bash
echo "Running checks..."
if [ -f "app.txt" ]; then
    echo "app.txt found"
    exit 0
else
    echo "app.txt missing"
    exit 1
fi
