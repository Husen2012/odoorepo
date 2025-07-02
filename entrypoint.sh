#!/bin/bash
set -e

# Create sessions directory if it doesn't exist
mkdir -p /var/lib/odoo/sessions
chown -R odoo:odoo /var/lib/odoo/sessions
chmod 755 /var/lib/odoo/sessions

# Wait for database to be ready
echo "Waiting for database to be ready..."
while ! pg_isready -h $HOST -p 6432 -U $USER; do
  echo "Database not ready, waiting..."
  sleep 2
done

echo "Database is ready, starting Odoo..."

# Execute the original entrypoint
exec "$@"
