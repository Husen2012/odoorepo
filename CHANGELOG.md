# Changelog

All notable changes to this project will be documented in this file.

## [2.0.0] - 2025-07-02

### 🚀 Major Enhancements

#### Added
- **Port Conflict Detection**: Automatically checks if ports are available before setup
- **Custom Redis and pgbouncer Ports**: Support for custom Redis and pgbouncer ports
- **Directory Existence Check**: Warns and asks for confirmation if directory exists
- **Colored Terminal Output**: Beautiful colored status messages and progress indicators
- **Docker Health Checks**: Comprehensive health checks for all services
- **Enhanced Error Handling**: Better error messages and graceful failure handling
- **Resource Management**: Memory limits and reservations for all containers
- **Sessions Directory**: Proper sessions directory with correct permissions

#### Improved
- **Docker Compose Command**: Updated from `docker-compose` to `docker compose`
- **Port Management**: Automatic port substitution in docker-compose.yml
- **Documentation**: Comprehensive README with examples and troubleshooting
- **Configuration**: Enhanced Odoo configuration with Redis and performance settings
- **Security**: Improved security settings and proxy mode configuration

#### Fixed
- **Port Conflicts**: Eliminates port conflicts between multiple instances
- **Permission Issues**: Proper permissions for sessions directory
- **Service Dependencies**: Correct service dependency order and health checks
- **Memory Management**: Proper memory limits to prevent system overload

### 🔧 Technical Changes

#### Infrastructure
- Upgraded to PostgreSQL 17
- Added Redis session storage
- Enhanced pgbouncer configuration
- Improved Docker Compose structure

#### Scripts
- Complete rewrite of run.sh with error handling
- Added parameter validation
- Implemented port availability checking
- Added colored output and progress indicators

#### Configuration
- Enhanced odoo.conf with Redis and performance settings
- Improved pgbouncer configuration
- Added proper health checks for all services
- Resource limits and reservations

### 📚 Documentation

#### Added
- Comprehensive README.md with examples
- Quick setup guide (SETUP.md)
- Detailed changelog (CHANGELOG.md)
- MIT License
- .gitignore for common files
- Inline documentation in scripts

#### Improved
- Clear usage examples
- Troubleshooting section
- Multiple instance deployment guide
- Performance tuning recommendations

### 🔄 Migration from v1.0

If you're upgrading from the original version:

1. **Backup your data** before upgrading
2. **Update your commands** to include Redis and pgbouncer ports:
   ```bash
   # Old way
   ./run.sh odoo18 10018 20018
   
   # New way (recommended)
   ./run.sh odoo18 10018 20018 6383 6436
   ```
3. **Check port conflicts** - the new version will detect and prevent them
4. **Review configuration** - new performance and Redis settings available

### 🙏 Credits

Based on the excellent work by [HaithamSaqr](https://github.com/HaithamSaqr/odoo-18-docker-compose-pgbouncer) with significant enhancements for production use and multi-instance deployment.

---

## [1.0.0] - Original Release

### Features
- Basic Odoo 18 Docker Compose setup
- PostgreSQL database
- pgbouncer connection pooling
- Redis support
- Basic configuration files

### Known Issues (Fixed in v2.0)
- Port conflicts between instances
- Uses deprecated docker-compose command
- Limited error handling
- No port availability checking
- Manual port configuration required
