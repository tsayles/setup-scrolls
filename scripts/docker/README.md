# 🎙️ Whisper & Piper Docker Setup

This directory contains scripts and Docker Compose configurations for
deploying Whisper (speech-to-text) and Piper (text-to-speech) services.

## 📋 Overview

- **Whisper**: OpenAI's speech recognition model for converting audio to
  text
- **Piper**: Fast, local neural text-to-speech system
- **Wyoming Protocol**: Both services use the Wyoming protocol for
  communication

## 🚀 Quick Start

Run the interactive setup script:

```bash
./whisper-piper-setup.sh
```

Or download and run directly from GitHub:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/tsayles/setup-scrolls/refs/heads/main/scripts/docker/whisper-piper-setup.sh)"
```

## 🖥️ CPU-Only Installation

The CPU-only installation provides a working setup without requiring GPU
acceleration.

### Prerequisites

- Docker (docker.io or docker-ce)
- Docker Compose (docker-compose or docker compose plugin)

### Services Deployed

1. **Whisper (Speech-to-Text)**
   - Image: `rhasspy/wyoming-whisper:latest`
   - Port: 10300
   - Model: base
   - Language: English

2. **Piper (Text-to-Speech)**
   - Image: `rhasspy/wyoming-piper:latest`
   - Port: 10200
   - Voice: en_US-lessac-medium

### Environment Variables

Both services support the following environment variables:

- `TZ`: Timezone (default: UTC)

### Volume Mounts

- `whisper-data`: Stores Whisper models and cache
- `piper-data`: Stores Piper voice models and cache

### Network Configuration

Both services are connected to the `voice-services` bridge network for
inter-container communication.

## 📝 Manual Usage

If you prefer to manage the services manually:

### Start Services

```bash
cd scripts/docker
docker compose -f docker-compose.cpu.yml up -d
```

### Check Status

```bash
docker compose -f docker-compose.cpu.yml ps
```

### View Logs

```bash
# All services
docker compose -f docker-compose.cpu.yml logs -f

# Specific service
docker compose -f docker-compose.cpu.yml logs -f whisper
docker compose -f docker-compose.cpu.yml logs -f piper
```

### Stop Services

```bash
docker compose -f docker-compose.cpu.yml down
```

### Remove Volumes

```bash
docker compose -f docker-compose.cpu.yml down -v
```

## 🔌 Service Endpoints

Once running, the services are available at:

- **Whisper**: `http://localhost:10300`
- **Piper**: `http://localhost:10200`

## 🏠 Integration with Home Assistant

These services use the Wyoming protocol and can be easily integrated
with Home Assistant:

1. Install the "Wyoming Protocol" integration in Home Assistant
2. Add the Whisper service:
   - Host: `<your-docker-host-ip>`
   - Port: `10300`
3. Add the Piper service:
   - Host: `<your-docker-host-ip>`
   - Port: `10200`

## 🔧 Customization

### Change Whisper Model

Edit `docker-compose.cpu.yml` and modify the whisper command:

```yaml
command: --model tiny --language en  # Faster, less accurate
command: --model base --language en  # Default, balanced
command: --model small --language en # Slower, more accurate
```

Available models: tiny, base, small, medium, large

### Change Piper Voice

Edit `docker-compose.cpu.yml` and modify the piper command:

```yaml
command: --voice en_US-lessac-medium        # Default
command: --voice en_US-amy-medium           # Alternative voice
command: --voice en_GB-alan-medium          # British English
```

See the [Piper voices
repository](https://github.com/rhasspy/piper/blob/master/VOICES.md)
for a full list of available voices.

### Change Ports

Edit `docker-compose.cpu.yml` and modify the port mappings:

```yaml
ports:
  - "10300:10300"  # Change first number to desired host port
```

## 🐛 Troubleshooting

### Services won't start

Check Docker logs:
```bash
docker compose -f docker-compose.cpu.yml logs
```

### Permission issues

Ensure the volumes have proper permissions:
```bash
docker compose -f docker-compose.cpu.yml down -v
docker compose -f docker-compose.cpu.yml up -d
```

### Network connectivity issues

Verify Docker network:
```bash
docker network ls
docker network inspect docker_voice-services
```

## 📚 Additional Resources

- [Wyoming Protocol
  Documentation](https://github.com/rhasspy/wyoming)
- [Whisper
  Repository](https://github.com/rhasspy/wyoming-whisper)
- [Piper Repository](https://github.com/rhasspy/wyoming-piper)
- [Home Assistant Voice
  Assistant](https://www.home-assistant.io/voice_control/)

## 🤝 Contributing

Found an issue or have a suggestion? Please open an issue or submit a
pull request!

---

> *"Number 1 most important thing is to have fun. Number 2 is to
> breathe, because it's hard to have fun if you're not breathing."*  
> — The Wise Man of the Internet
