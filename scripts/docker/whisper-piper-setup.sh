#!/bin/bash
#
# Script: whisper-piper-setup.sh
# Version: 1.0.0
# Author: The Wise Man of the Internet
# Purpose: Menu-driven installer for Whisper and Piper with GPU or CPU 
#          options
# Prerequisites: Docker, docker-compose
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
    - Docker Compose (docker-compose or docker compose plugin)
    - NVIDIA GPU drivers (optional, for GPU acceleration)

FEATURES:
    - Interactive menu-driven installation
    - GPU or CPU deployment options
    - Automatic dependency checking
    - Docker Compose configuration generation

EXAMPLES:
    # Run the interactive setup wizard
    ./whisper-piper-setup.sh

    # Display this help message
    ./whisper-piper-setup.sh --help

AUTHOR:
    The Wise Man of the Internet

VERSION:
    1.0.0

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
    
    # Get the directory where the script is located
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    COMPOSE_FILE="${SCRIPT_DIR}/docker-compose.cpu.yml"
    
    # Check if docker-compose.cpu.yml exists
    if [ ! -f "${COMPOSE_FILE}" ]; then
        print_error "Docker Compose file not found: ${COMPOSE_FILE}"
        return 1
    fi
    
    print_info "Using Docker Compose file: ${COMPOSE_FILE}"
    print_info "This will configure Whisper and Piper for CPU-only operation"
    echo ""
    
    # Display service information
    print_info "Services to be deployed:"
    echo "  - Whisper (Speech-to-Text) - Port 10300"
    echo "  - Piper (Text-to-Speech)   - Port 10200"
    echo ""
    
    # Ask for confirmation
    echo -n "Continue with installation? [y/N]: "
    read -r confirm
    if [[ ! $confirm =~ ^[Yy]$ ]]; then
        print_info "Installation cancelled"
        return 0
    fi
    
    print_info "Pulling Docker images..."
    if ! docker compose -f "${COMPOSE_FILE}" pull; then
        print_error "Failed to pull Docker images"
        return 1
    fi
    print_success "Docker images pulled successfully"
    
    print_info "Starting services..."
    if ! docker compose -f "${COMPOSE_FILE}" up -d; then
        print_error "Failed to start services"
        return 1
    fi
    print_success "Services started successfully"
    
    echo ""
    print_success "Installation complete!"
    echo ""
    print_info "Service endpoints:"
    echo "  - Whisper: http://localhost:10300"
    echo "  - Piper:   http://localhost:10200"
    echo ""
    print_info "To check service status:"
    echo "  docker compose -f ${COMPOSE_FILE} ps"
    echo ""
    print_info "To view logs:"
    echo "  docker compose -f ${COMPOSE_FILE} logs -f"
    echo ""
    print_info "To stop services:"
    echo "  docker compose -f ${COMPOSE_FILE} down"
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
