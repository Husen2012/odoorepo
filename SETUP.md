# 🚀 Quick Setup Guide

## Prerequisites

Before running the setup, ensure you have:

- ✅ **Docker** installed and running
- ✅ **Docker Compose** plugin installed
- ✅ **Git** installed (for cloning)
- ✅ **Root/sudo access** (for system configurations)

## Installation Methods

### Method 1: One-Line Installation (Recommended)

```bash
cd /opt
curl -s https://raw.githubusercontent.com/Husen2012/odoorepo/main/run.sh | sudo bash -s odoo18 10018 20018 6383 6436
```

### Method 2: Manual Installation

```bash
# 1. Clone the repository
git clone https://github.com/Husen2012/odoorepo.git
cd odoorepo

# 2. Make script executable
chmod +x run.sh

# 3. Run setup
sudo ./run.sh odoo18 10018 20018 6383 6436
```

## Multiple Instances Setup

```bash
# Production instance
sudo ./run.sh odoo-prod 10018 20018 6383 6436

# Development instance
sudo ./run.sh odoo-dev 10019 20019 6384 6437

# Testing instance
sudo ./run.sh odoo-test 10020 20020 6385 6438
```

## Post-Installation

1. **Access your instance**: `http://your-server-ip:10018`
2. **Master password**: `P@ss@123`
3. **Create your first database** through the web interface
4. **Add custom addons** to the `addons/` directory

## Common Port Ranges

| Instance Type | Main Port | Longpolling | Redis | pgbouncer |
|---------------|-----------|-------------|-------|-----------|
| Production    | 10018     | 20018       | 6383  | 6436      |
| Development   | 10019     | 20019       | 6384  | 6437      |
| Testing       | 10020     | 20020       | 6385  | 6438      |
| Staging       | 10021     | 20021       | 6386  | 6439      |

## Verification

After installation, verify everything is working:

```bash
# Check if containers are running
docker compose ps

# Test the web interface
curl -I http://localhost:10018

# Check logs
docker compose logs -f
```

## Next Steps

1. 📚 Read the full [README.md](README.md) for detailed documentation
2. 🔧 Customize your [odoo.conf](etc/odoo.conf) if needed
3. 📦 Add your custom addons to the `addons/` directory
4. 🔒 Consider changing default passwords for production use
5. 🔄 Set up backups for your data

## Need Help?

- 📖 Check the [README.md](README.md) for detailed documentation
- 🐛 Report issues on [GitHub Issues](https://github.com/YOUR_USERNAME/enhanced-odoo-18-docker/issues)
- 💬 Join discussions on [GitHub Discussions](https://github.com/YOUR_USERNAME/enhanced-odoo-18-docker/discussions)
