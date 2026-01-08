# Homebox Home Assistant Add-on

Home inventory and organization system built for the home user!

## About

Homebox is a simple, fast, and portable inventory management system designed specifically for home users. Perfect for tracking:

- 📦 Household items and possessions
- 🏠 Room-by-room organization
- 📝 Warranties and documentation
- 🏷️ Items with labels and locations
- 📊 Purchase history and values
- 📷 Photos and attachments

## Features

- **Simple & Easy** - No complicated setup, just start adding items
- **Fast** - Written in Go, uses minimal resources (~50MB RAM)
- **Portable** - SQLite database, easy to backup
- **Rich Organization** - Categories, locations, labels, and more
- **Multi-tenant** - Support for multiple users/groups
- **Attachments** - Add photos, receipts, manuals
- **Search** - Full-text search across all items
- **QR Codes** - Generate labels for physical items

## Installation

1. Add this repository to your Home Assistant add-on store
2. Click "Install" on the Homebox add-on
3. Start the add-on
4. Click "Open Web UI"
5. Create your admin account
6. Start adding items!

## Configuration

### Log Level
```yaml
log_level: info
```
Options: `debug`, `info`, `warn`, `error`

### Max Upload Size
```yaml
max_upload_size: 10
```
Maximum file upload size in MB (for photos/attachments)

### Allow Registration
```yaml
allow_registration: true
```
Allow new users to register. Set to `false` after creating your account for security.

## Usage

### First Time Setup

1. **Create Account**
   - Click "Open Web UI"
   - First user becomes admin
   - Recommended: Disable registration after creating accounts

2. **Create Locations**
   - Settings → Locations
   - Add rooms, storage areas, etc.
   - Can create hierarchies (Living Room → Bookshelf → Top Shelf)

3. **Create Labels**
   - Settings → Labels  
   - Add categories like "Electronics", "Furniture", "Important Docs"
   - Use colors to differentiate

4. **Add Items**
   - Click "Create Item"
   - Add name, description, location, labels
   - Upload photos
   - Add purchase info, warranty dates, serial numbers

### Tips

- **Use QR codes** - Generate and print QR labels for quick lookups
- **Add photos** - Helps with insurance claims and identification
- **Track warranties** - Get notified before warranties expire
- **Serial numbers** - Essential for insurance and support
- **Receipts** - Attach digital copies of receipts

## Data Storage

All data is stored in `/data/` which persists across restarts:
- Database: `/data/homebox.db`
- Attachments: `/data/attachments/`

## Backup

To backup your data:

1. **Via Home Assistant**
   - Settings → System → Backups
   - Select Homebox add-on
   - Create backup

2. **Manual Backup**
   ```bash
   # SSH to Home Assistant
   cd /mnt/data/supervisor/addons/data/slug_homebox/
   tar -czf homebox-backup.tar.gz data/
   ```

## Support

- **Documentation**: https://homebox.software/
- **GitHub**: https://github.com/sysadminsmedia/homebox
- **Issues**: Report bugs on GitHub

## Credits

- **Homebox** by hay-kot (original) and sysadminsmedia (continued)
- **Add-on** packaged for Home Assistant

---

**Note**: Homebox is in active development. Features and UI may change.
