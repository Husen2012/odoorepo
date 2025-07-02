#!/bin/bash

# Enhanced Odoo 18 Docker Compose Setup with pgbouncer
# Usage: ./run.sh <instance_name> <main_port> <longpolling_port> [redis_port] [pgbouncer_port]
# Example: ./run.sh odoo18 10018 20018 6383 6436

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  Enhanced Odoo 18 Docker Setup${NC}"
    echo -e "${BLUE}================================${NC}"
}

# Check if required parameters are provided
if [ $# -lt 3 ]; then
    print_error "Usage: $0 <instance_name> <main_port> <longpolling_port> [redis_port] [pgbouncer_port]"
    print_error "Example: $0 odoo18 10018 20018 6383 6436"
    exit 1
fi

# Parameters
INSTANCE_NAME=$1
MAIN_PORT=$2
LONGPOLLING_PORT=$3
REDIS_PORT=${4:-6379}
PGBOUNCER_PORT=${5:-6432}

print_header
print_status "Setting up Odoo instance: $INSTANCE_NAME"
print_status "Main port: $MAIN_PORT"
print_status "Longpolling port: $LONGPOLLING_PORT"
print_status "Redis port: $REDIS_PORT"
print_status "pgbouncer port: $PGBOUNCER_PORT"

# Check if directory already exists
if [ -d "$INSTANCE_NAME" ]; then
    print_warning "Directory '$INSTANCE_NAME' already exists!"
    read -p "Do you want to continue and overwrite? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_error "Setup cancelled by user"
        exit 1
    fi
    print_status "Removing existing directory..."
    rm -rf "$INSTANCE_NAME"
fi

# Check if ports are available
check_port() {
    local port=$1
    local service=$2
    if netstat -tuln 2>/dev/null | grep -q ":$port "; then
        print_error "Port $port ($service) is already in use!"
        print_error "Please choose a different port or stop the service using that port"
        exit 1
    fi
}

print_status "Checking port availability..."
check_port $MAIN_PORT "Odoo main"
check_port $LONGPOLLING_PORT "Odoo longpolling"
check_port $REDIS_PORT "Redis"
check_port $PGBOUNCER_PORT "pgbouncer"

# Check if Docker is installed and running
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed. Please install Docker first."
    exit 1
fi

if ! docker info &> /dev/null; then
    print_error "Docker is not running. Please start Docker first."
    exit 1
fi

# Check if Docker Compose is available
if ! docker compose version &> /dev/null; then
    print_error "Docker Compose is not available. Please install Docker Compose plugin."
    exit 1
fi

print_status "Cloning repository..."
git clone --depth=1 https://github.com/HaithamSaqr/odoo-18-docker-compose-pgbouncer.git "$INSTANCE_NAME"

cd "$INSTANCE_NAME"

# Remove git history
rm -rf .git

print_status "Configuring ports..."

# Update docker-compose.yml with custom ports
sed -i "s/8069:8069/$MAIN_PORT:8069/g" docker-compose.yml
sed -i "s/8072:8072/$LONGPOLLING_PORT:8072/g" docker-compose.yml
sed -i "s/6379:6379/$REDIS_PORT:6379/g" docker-compose.yml
sed -i "s/6432:6432/$PGBOUNCER_PORT:6432/g" docker-compose.yml

# Update any additional port references in the compose file
sed -i "s/\"10018:8069\"/\"$MAIN_PORT:8069\"/g" docker-compose.yml
sed -i "s/\"20018:8072\"/\"$LONGPOLLING_PORT:8072\"/g" docker-compose.yml

print_status "Setting up system configurations..."

# Set system configurations
echo "fs.inotify.max_user_watches = 524288" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "kernel.panic = 10" >> /etc/sysctl.conf
sysctl -p

print_status "Creating necessary directories..."
mkdir -p addons postgresql pgbouncer sessions
chmod 777 sessions

print_status "Starting Docker containers..."
docker compose up -d

# Wait for services to be ready
print_status "Waiting for services to start..."
sleep 10

# Check if services are running
if docker compose ps | grep -q "Up"; then
    print_status "✅ Odoo instance '$INSTANCE_NAME' started successfully!"
    echo
    print_status "🌐 Access URLs:"
    print_status "   Main: http://localhost:$MAIN_PORT"
    print_status "   Master Password: P@ss@123"
    print_status "   Longpolling: http://localhost:$LONGPOLLING_PORT"
    echo
    print_status "🔧 Service Ports:"
    print_status "   Redis: $REDIS_PORT"
    print_status "   pgbouncer: $PGBOUNCER_PORT"
    echo
    print_status "📁 Instance Directory: $(pwd)"
    print_status "📝 Add your custom addons to: $(pwd)/addons/"
    echo
    print_status "🐳 Docker Commands:"
    print_status "   View logs: docker compose logs -f"
    print_status "   Stop: docker compose down"
    print_status "   Restart: docker compose restart"
else
    print_error "❌ Failed to start some services. Check logs with: docker compose logs"
    exit 1
fi
