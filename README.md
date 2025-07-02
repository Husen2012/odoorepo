# 🚀 Enhanced Odoo 18 Docker Compose with pgbouncer

A production-ready, enhanced Docker Compose setup for Odoo 18 with PostgreSQL, Redis, and pgbouncer connection pooling. Perfect for deploying multiple Odoo instances with automatic port management and conflict detection.

## ✨ Features

- **🐳 Complete Docker Stack**: Odoo 18, PostgreSQL 17, Redis, pgbouncer
- **🔧 Automatic Port Management**: Prevents port conflicts between instances
- **⚡ Performance Optimized**: Connection pooling with pgbouncer
- **🔄 Redis Session Storage**: Improved session management
- **📊 Resource Management**: Memory limits and health checks
- **🛡️ Production Ready**: Security configurations and error handling
- **🎨 Colored Output**: Beautiful terminal output with status indicators
- **🔍 Port Conflict Detection**: Automatically checks for port availability

## 🚀 Quick Start

### One-Line Installation

```bash
cd /opt
curl -s https://raw.githubusercontent.com/YOUR_USERNAME/enhanced-odoo-18-docker/main/run.sh | sudo bash -s odoo18 10018 20018 6383 6436
```

### Manual Installation

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/enhanced-odoo-18-docker.git
cd enhanced-odoo-18-docker

# Make the script executable
chmod +x run.sh

# Run the setup
./run.sh <instance_name> <main_port> <longpolling_port> [redis_port] [pgbouncer_port]
```

## 📋 Usage Examples

### Basic Usage (Default Redis and pgbouncer ports)
```bash
./run.sh odoo18 10018 20018
```

### Full Custom Ports (Recommended for multiple instances)
```bash
./run.sh odoo18-prod 10018 20018 6383 6436
./run.sh odoo18-dev  10019 20019 6384 6437
./run.sh odoo18-test 10020 20020 6385 6438
```

### Multiple Instances Example
```bash
# Production instance
./run.sh odoo-prod 10018 20018 6383 6436

# Development instance  
./run.sh odoo-dev 10019 20019 6384 6437

# Testing instance
./run.sh odoo-test 10020 20020 6385 6438
```

## 🔧 Parameters

| Parameter | Description | Required | Default |
|-----------|-------------|----------|---------|
| `instance_name` | Name of the Odoo instance directory | ✅ Yes | - |
| `main_port` | Main Odoo web interface port | ✅ Yes | - |
| `longpolling_port` | Odoo longpolling/WebSocket port | ✅ Yes | - |
| `redis_port` | Redis server port | ❌ No | 6379 |
| `pgbouncer_port` | pgbouncer connection pooler port | ❌ No | 6432 |

## 🌐 Access Your Instance

After successful installation:

- **Main Interface**: `http://your-server-ip:main_port`
- **Master Password**: `P@ss@123`
- **Database Management**: Available through the web interface

## 📁 Directory Structure

```
your-instance-name/
├── docker-compose.yml      # Main Docker Compose configuration
├── etc/
│   └── odoo.conf          # Odoo configuration file
├── pgbouncer/
│   └── userlist.txt       # pgbouncer user authentication
├── addons/                # Custom addons directory
├── postgresql/            # PostgreSQL data (auto-created)
└── sessions/              # Odoo sessions directory
```

## 🐳 Docker Commands

```bash
# View logs
docker compose logs -f

# Stop the instance
docker compose down

# Restart services
docker compose restart

# View running containers
docker compose ps

# Access Odoo container shell
docker compose exec odoo18 bash
```

## ⚙️ Configuration

### Default Credentials
- **Master Password**: `P@ss@123`
- **Database User**: `odoo`
- **Database Password**: `odoo18@2024`

### Performance Settings
- **Workers**: 4
- **Memory Limit**: 2GB soft, 2.5GB hard
- **Connection Pool**: 30 connections via pgbouncer
- **Redis**: Session storage enabled

## 🔒 Security Features

- Database listing disabled (`list_db = False`)
- Proxy mode enabled for reverse proxy compatibility
- Resource limits to prevent memory exhaustion
- Health checks for all services

## 🛠️ Customization

### Adding Custom Addons
```bash
# Copy your addons to the addons directory
cp -r /path/to/your/addon /opt/your-instance-name/addons/

# Restart Odoo to load new addons
cd /opt/your-instance-name
docker compose restart odoo18
```

### Modifying Configuration
Edit the configuration file:
```bash
nano /opt/your-instance-name/etc/odoo.conf
docker compose restart odoo18
```

## 🚨 Troubleshooting

### Port Already in Use
```bash
# Check what's using the port
sudo netstat -tulpn | grep :10018

# Kill the process or choose different ports
./run.sh odoo18 10019 20019 6384 6437
```

### Database Connection Issues
```bash
# Check pgbouncer logs
docker compose logs pgbouncer

# Check database logs
docker compose logs db
```

### Performance Issues
```bash
# Monitor resource usage
docker stats

# Check Odoo logs
docker compose logs odoo18
```

## 📊 Monitoring

### Health Checks
All services include health checks:
- PostgreSQL: `pg_isready`
- Redis: `redis-cli ping`
- pgbouncer: Database connectivity

### Resource Monitoring
```bash
# View resource usage
docker compose top

# Monitor logs in real-time
docker compose logs -f --tail=100
```

## 🔄 Updates

### Updating Odoo
```bash
cd /opt/your-instance-name
docker compose pull odoo18
docker compose up -d odoo18
```

### Backup
```bash
# Backup database
docker compose exec db pg_dump -U odoo postgres > backup.sql

# Backup entire instance
tar -czf instance-backup.tar.gz /opt/your-instance-name/
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Based on the original work by [HaithamSaqr](https://github.com/HaithamSaqr/odoo-18-docker-compose-pgbouncer)
- Enhanced for production use and multiple instance deployment
- Community feedback and contributions

## 📞 Support

- 🐛 **Issues**: [GitHub Issues](https://github.com/YOUR_USERNAME/enhanced-odoo-18-docker/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/YOUR_USERNAME/enhanced-odoo-18-docker/discussions)
- 📧 **Email**: your-email@example.com

---

⭐ **Star this repository if it helped you!**
