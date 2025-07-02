# Custom Addons Directory

This directory is for your custom Odoo addons.

## Adding Addons

1. Copy your addon directories here
2. Restart the Odoo container: `docker compose restart odoo18`
3. Update the addon list in Odoo's Apps menu
4. Install your custom addons

## Example Structure

```
addons/
├── your_custom_addon/
│   ├── __init__.py
│   ├── __manifest__.py
│   ├── models/
│   ├── views/
│   └── static/
└── another_addon/
    ├── __init__.py
    ├── __manifest__.py
    └── ...
```

## Notes

- This directory is mounted as `/mnt/extra-addons` inside the container
- Make sure your addon directories have proper permissions
- Restart Odoo after adding new addons
