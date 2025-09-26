#!/bin/bash

# YAML Validation Script
echo "🔍 Validating YAML files..."

# Function to validate YAML syntax
validate_yaml() {
    local file="$1"
    echo "Validating: $file"
    
    # Check YAML syntax with Python
    if python3 -c "import yaml; yaml.safe_load(open('$file'))" 2>/dev/null; then
        echo "✅ YAML syntax valid"
    else
        echo "❌ YAML syntax invalid"
        return 1
    fi
    
    # Check with kubectl if available
    if command -v kubectl &> /dev/null; then
        echo "🔍 Validating Kubernetes resources..."
        if kubectl apply --dry-run=client -f "$file" &>/dev/null; then
            echo "✅ Kubernetes resources valid"
        else
            echo "❌ Kubernetes resources invalid"
            kubectl apply --dry-run=client -f "$file"
            return 1
        fi
    fi
    
    echo ""
}

# Validate all YAML files
for file in *.yaml *.yml 2>/dev/null; do
    if [ -f "$file" ]; then
        validate_yaml "$file"
    fi
done

echo "🎉 Validation complete!"