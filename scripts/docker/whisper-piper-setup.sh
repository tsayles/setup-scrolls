#!/bin/bash
#
# Script: whisper-piper-setup.sh
# Version: 1.1.0
# Author: The Wise Man of the Internet
# Purpose: Menu-driven installer for Whisper and Piper with GPU or CPU 
#          options
# Prerequisites: Docker
#
# Description:
#   This script provides an interactive menu to set up Whisper 
#   (speech-to-text) and Piper (text-to-speech) services using Docker 
#   containers. It supports both GPU-accelerated and CPU-only deployments.
#
# Features:
#   - Interactive menu-driven installation
#   - GPU or CPU deployment options
#   - Automatic dependency checking
#   - Simple Docker container deployment
#

set -e  # Exit on error
set -u  # Exit on undefined variable

# Color codes for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display help message
show_help() {
    cat << EOF
🧙‍♂️ Whisper & Piper Setup Script

USAGE:
    ./whisper-piper-setup.sh [OPTIONS]

DESCRIPTION:
    Menu-driven installer for Whisper (speech-to-text) and Piper 
    (text-to-speech) services using Docker containers. Supports both 
    GPU-accelerated and CPU-only deployments.

OPTIONS:
    -h, --help      Display this help message and exit

PREREQUISITES:
    - Docker (docker.io or docker-ce)
    - NVIDIA GPU drivers (optional, for GPU acceleration)
    - NVIDIA Container Toolkit (optional, for GPU acceleration)

FEATURES:
    - Interactive menu-driven installation
    - GPU or CPU deployment options
    - Automatic dependency checking
    - Simple Docker container deployment

EXAMPLES:
    # Run the interactive setup wizard
    ./whisper-piper-setup.sh

    # Display this help message
    ./whisper-piper-setup.sh --help

AUTHOR:
    The Wise Man of the Internet

VERSION:
    1.1.0

EOF
    exit 0
}

# Function to print colored messages
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if Docker is installed
check_docker() {
    print_info "Checking for Docker installation..."
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    print_success "Docker is installed"
}

# Function to check if Docker Compose is installed
check_docker_compose() {
    print_info "Checking for Docker Compose..."
    if ! docker compose version &> /dev/null && ! command -v docker-compose &> /dev/null; then
        print_error "Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
    print_success "Docker Compose is available"
}

# Function to check for GPU support
check_gpu() {
    print_info "Checking for GPU support..."
    if command -v nvidia-smi &> /dev/null; then
        if nvidia-smi &> /dev/null; then
            print_success "NVIDIA GPU detected"
            return 0
        fi
    fi
    print_warning "No NVIDIA GPU detected or nvidia-smi not available"
    return 1
}

# Function to display the main menu
show_menu() {
    echo ""
    echo "======================================"
    echo "  Whisper & Piper Setup Wizard"
    echo "======================================"
    echo "1) Install with GPU support"
    echo "2) Install with CPU only"
    echo "3) Check system requirements"
    echo "4) Exit"
    echo "======================================"
    echo -n "Select an option [1-4]: "
}

# Function to check system requirements
check_requirements() {
    echo ""
    print_info "Checking system requirements..."
    check_docker
    check_gpu
    echo ""
    print_success "System check complete!"
}

# Function to install with GPU support
install_gpu() {
    print_info "Starting installation with GPU support..."
    check_gpu || {
        print_error "GPU not detected. Please use CPU installation instead."
        return 1
    }
    
    # Pull GPU-accelerated images
    print_info "Pulling GPU-accelerated images (this may take a while)..."
    if docker pull ghcr.io/ggerganov/whisper.cpp:latest; then
        print_success "Whisper image pulled successfully"
    else
        print_error "Failed to pull Whisper image"
        return 1
    fi
    
    if docker pull rhasspy/piper:latest; then
        print_success "Piper image pulled successfully"
    else
        print_error "Failed to pull Piper image"
        return 1
    fi
    
    # Remove any existing containers
    print_info "Removing any existing containers..."
    docker rm -f whisper piper 2>/dev/null || true
    
    # Start containers with GPU support
    print_info "Starting Whisper container with GPU support..."
    if docker run -d --name whisper --gpus all ghcr.io/ggerganov/whisper.cpp:latest; then
        print_success "Whisper container started successfully with GPU"
    else
        print_error "Failed to start Whisper container with GPU"
        return 1
    fi
    
    print_info "Starting Piper container with GPU support..."
    if docker run -d --name piper --gpus all rhasspy/piper:latest; then
        print_success "Piper container started successfully with GPU"
    else
        print_error "Failed to start Piper container with GPU"
        return 1
    fi
    
    # Display service information
    echo ""
    print_success "GPU-accelerated installation complete!"
    echo ""
    echo "======================================"
    echo "  Service Information"
    echo "======================================"
    echo "🎙️  Whisper (Speech-to-Text):"
    echo "   Container: whisper"
    echo "   Mode: GPU (NVIDIA)"
    echo ""
    echo "🔊 Piper (Text-to-Speech):"
    echo "   Container: piper"
    echo "   Mode: GPU (NVIDIA)"
    echo ""
    echo "======================================"
    echo "Useful commands:"
    echo "  View logs:     docker logs -f whisper"
    echo "                 docker logs -f piper"
    echo "  Stop services: docker stop whisper piper"
    echo "  Start services: docker start whisper piper"
    echo "  Remove setup:  docker rm -f whisper piper"
    echo "======================================"
    echo ""
}

# Function to install with CPU only
install_cpu() {
    print_info "Starting installation with CPU support..."
    
    # Pull CPU-compatible images
    print_info "Pulling CPU-compatible images (this may take a while)..."
    if docker pull ghcr.io/ggerganov/whisper.cpp:latest; then
        print_success "Whisper image pulled successfully"
    else
        print_error "Failed to pull Whisper image"
        return 1
    fi
    
    if docker pull rhasspy/piper:latest; then
        print_success "Piper image pulled successfully"
    else
        print_error "Failed to pull Piper image"
        return 1
    fi
    
    # Remove any existing containers
    print_info "Removing any existing containers..."
    docker rm -f whisper piper 2>/dev/null || true
    
    # Start containers in CPU mode
    print_info "Starting Whisper container in CPU mode..."
    if docker run -d --name whisper ghcr.io/ggerganov/whisper.cpp:latest; then
        print_success "Whisper container started successfully"
    else
        print_error "Failed to start Whisper container"
        return 1
    fi
    
    print_info "Starting Piper container in CPU mode..."
    if docker run -d --name piper rhasspy/piper:latest; then
        print_success "Piper container started successfully"
    else
        print_error "Failed to start Piper container"
        return 1
    fi
    
    # Display service information
    echo ""
    print_success "CPU-only installation complete!"
    echo ""
    echo "======================================"
    echo "  Service Information"
    echo "======================================"
    echo "🎙️  Whisper (Speech-to-Text):"
    echo "   Container: whisper"
    echo "   Mode: CPU"
    echo ""
    echo "🔊 Piper (Text-to-Speech):"
    echo "   Container: piper"
    echo "   Mode: CPU"
    echo ""
    echo "======================================"
    echo "Useful commands:"
    echo "  View logs:     docker logs -f whisper"
    echo "                 docker logs -f piper"
    echo "  Stop services: docker stop whisper piper"
    echo "  Start services: docker start whisper piper"
    echo "  Remove setup:  docker rm -f whisper piper"
    echo "======================================"
    echo ""
}

# Main script execution
main() {
    echo "🧙‍♂️ Welcome to the Whisper & Piper Setup Script"
    
    while true; do
        show_menu
        read -r choice
        
        case $choice in
            1)
                install_gpu
                ;;
            2)
                install_cpu
                ;;
            3)
                check_requirements
                ;;
            4)
                print_info "Exiting setup wizard. May your scrolls serve you well!"
                exit 0
                ;;
            *)
                print_error "Invalid option. Please select 1-4."
                ;;
        esac
    done
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
    shift
done

# Run main function
main
