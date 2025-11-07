#!/bin/bash
#
# Script: whisper-piper-setup.sh
# Purpose: Menu-driven installer for Whisper and Piper with GPU or CPU options
# Author: The Wise Man of the Internet
# Usage: ./whisper-piper-setup.sh
# Prerequisites: Docker, docker-compose
#
# Description:
#   This script provides an interactive menu to set up Whisper (speech-to-text)
#   and Piper (text-to-speech) services using Docker containers. It supports
#   both GPU-accelerated and CPU-only deployments.
#
# Features:
#   - Interactive menu-driven installation
#   - GPU or CPU deployment options
#   - Automatic dependency checking
#   - Docker Compose configuration generation
#

set -e  # Exit on error
set -u  # Exit on undefined variable

# Color codes for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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
        nvidia-smi &> /dev/null
        if [ $? -eq 0 ]; then
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
    check_docker_compose
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
    
    # TODO: Implement GPU-enabled Docker Compose setup
    print_warning "GPU installation not yet implemented"
    print_info "This will configure Whisper and Piper with NVIDIA GPU acceleration"
}

# Function to install with CPU only
install_cpu() {
    print_info "Starting installation with CPU support..."
    
    # TODO: Implement CPU-only Docker Compose setup
    print_warning "CPU installation not yet implemented"
    print_info "This will configure Whisper and Piper for CPU-only operation"
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

# Run main function
main
