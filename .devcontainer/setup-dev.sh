#!/bin/zsh

# Ze# Note: Frontend dependencies are handled by Docker containers
echo "📦 Frontend dependencies are managed by Docker containers"

# Set up Python virtual environment for services development
echo "🐍 Setting up Python environment..."evelopment Environment Setup Script
# This script sets up the development environment after the container starts

echo "🚀 Setting up ZeroDotQ development environment..."

# Ensure we're using Docker Compose plugin (docker compose) instead of standalone docker-compose
alias docker-compose='docker compose'

# Check if we're in the right directory
if [ ! -f "docker-compose.yml" ]; then
    echo "❌ Please run this script from the project root directory"
    exit 1
fi

# Note: Frontend dependencies are handled by Docker containers
echo "� Frontend dependencies are managed by Docker containers"
    echo "⚠️  No package.json found in frontend directory"
fi
cd ..

# Set up Python virtual environment for services development
echo "🐍 Setting up Python virtual environment..."



# Install learning service dependencies
if [ -f "services/learning-service/requirements.txt" ]; then
    pip install -r services/learning-service/requirements.txt
    echo "✅ Learning service dependencies installed"
fi

# Install simulation service dependencies
if [ -f "services/simulation-service/requirements.txt" ]; then
    pip install -r services/simulation-service/requirements.txt
    echo "✅ Simulation service dependencies installed"
fi

# Install pre-commit hooks if .pre-commit-config.yaml exists
if [ -f ".pre-commit-config.yaml" ]; then
    echo "🪝 Installing pre-commit hooks..."
    pre-commit install
    echo "✅ Pre-commit hooks installed"
fi

echo "🎉 Development environment setup complete!"
echo ""
echo "Available commands:"
echo "  Start all services: docker compose up"
echo "  Start dev services: docker compose -f docker-compose.dev.yml up"
echo "  Start microservices: ./start-microservices.sh"
echo "  Start microservices: ./start-microservices.sh"
echo ""
echo "Make sure to start the database and Redis with: docker compose up postgres redis"
