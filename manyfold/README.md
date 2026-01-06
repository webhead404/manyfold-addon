# Home Assistant Add-on: Manyfold

![Manyfold Logo](https://manyfold.app/images/roundel.svg)

Manyfold is a self-hosted digital asset manager for 3D print files. View and organize your collection of 3D models in full interactive 3D, sort by tags, creators, and collections, and share content publicly or privately.

## About

This add-on runs Manyfold directly in Home Assistant OS, making it easy to manage your 3D printing model library alongside your smart home. Perfect for makers who want to keep everything in one place!

### Features

- 📦 **Interactive 3D Viewer**: View your models in full 3D directly in your browser
- 🏷️ **Smart Organization**: Tag, categorize, and organize models by creator, collection, and more
- 🔍 **Powerful Search**: Find models quickly with full-text search
- 📤 **Easy Upload**: Drag and drop files or upload entire folders
- 🌐 **Federation**: Connect with other Manyfold instances via ActivityPub (like Mastodon for 3D models!)
- 📊 **File Analysis**: Automatic extraction of model metadata and previews
- 🔐 **Privacy First**: All data stays on your server
- 📱 **Mobile Friendly**: Responsive interface works great on phones and tablets

### Supported File Formats

**3D Models:**
- STL, OBJ, 3MF, PLY, AMF, FBX, DAE (COLLADA), glTF/GLB, 3DS

**Images:**
- PNG, JPG, GIF, WebP

**Documents:**
- PDF, Markdown, Text files

**Other:**
- Gerber files (PCB designs)
- KiCad projects
- ZIP archives (automatically extracted)

## Installation

1. Navigate to the **Supervisor** tab in Home Assistant
2. Click on the **Add-on Store**
3. Click the three dots (⋮) in the top right corner
4. Select **Repositories**
5. Add this repository URL:
   ```
   https://github.com/YOUR_USERNAME/hassio-addons
   ```
6. Find **Manyfold** in the add-on store
7. Click **Install**
8. Wait for the installation to complete
9. Click **Start**
10. Check the logs to see it starting up
11. Access Manyfold via the **Open Web UI** button or at `http://homeassistant.local:3214`

## Configuration

### Basic Configuration

```yaml
database_type: sqlite
puid: 1000
pgid: 1000
model_libraries: []
```

### Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `database_type` | string | `sqlite` | Database type: `sqlite`, `postgresql`, or `mysql` |
| `database_host` | string | - | Database host (required for PostgreSQL/MySQL) |
| `database_port` | int | - | Database port |
| `database_name` | string | - | Database name |
| `database_user` | string | - | Database username |
| `database_password` | string | - | Database password |
| `puid` | int | `1000` | User ID for file permissions |
| `pgid` | int | `1000` | Group ID for file permissions |
| `model_libraries` | list | `[]` | List of model library paths (optional) |
| `multiuser_enabled` | bool | `false` | Enable multiuser mode |
| `registration_enabled` | bool | `false` | Allow user registration |
| `usage_tracking_enabled` | bool | `false` | Send anonymous usage statistics |

### Example: SQLite (Default - Recommended for most users)

```yaml
database_type: sqlite
puid: 1000
pgid: 1000
```

The database file will be stored in `/data/manyfold.db` within the add-on container, which is persisted across restarts.

### Example: External PostgreSQL Database

```yaml
database_type: postgresql
database_host: 192.168.1.100
database_port: 5432
database_name: manyfold
database_user: manyfold
database_password: "your-secure-password"
puid: 1000
pgid: 1000
```

### Example: Multiuser Mode

```yaml
database_type: sqlite
puid: 1000
pgid: 1000
multiuser_enabled: true
registration_enabled: true
```

## Setting Up Your First Library

After starting the add-on:

1. Open the Web UI (port 3214)
2. Create an administrator account on first visit
3. Go to **Settings** → **Libraries**
4. Click **New Library**
5. Enter a name for your library
6. Enter a path:
   - `/share/3dmodels` - for models in Home Assistant's `share` folder
   - `/media/3dmodels` - for models in your media folder
   - `/config/3dmodels` - for models in your config folder
7. Click **Create**
8. The library will be scanned automatically

### Recommended Directory Structure

Create folders in Home Assistant to organize your models:

```
/share/
  └── 3dmodels/
      ├── miniatures/
      ├── functional-prints/
      ├── decorations/
      └── prototypes/
```

You can access these via Samba/SSH to upload your STL files.

## Accessing Your Files

### Via Samba (Recommended)

1. Install the **Samba share** add-on if not already installed
2. Access your Home Assistant via network share
3. Navigate to the `share` folder
4. Create a `3dmodels` folder
5. Copy your STL and model files there

### Via SSH/Terminal

1. Install the **Terminal & SSH** add-on
2. Create directory: `mkdir -p /share/3dmodels`
3. Upload files via SCP or similar

### Via File Editor

For smaller files, you can use the File Editor add-on to create directories.

## Usage Examples

### Organize Models by Project

1. Upload models for a project
2. Create a **Collection** for the project
3. Tag models with relevant keywords
4. Add creator information
5. Share the collection URL with others (if using multiuser mode)

### Integration with OctoPrint

1. Set up Manyfold with your model library
2. When you want to print, browse your organized collection
3. Download the model you want
4. Upload to OctoPrint or your slicer

### Federation Features

Enable federation to:
- Follow other Manyfold instances
- Share your public models on the Fediverse
- Discover models from other makers
- Connect with the 3D printing community

## Troubleshooting

### Web UI Not Loading

- Check the add-on logs for errors
- Ensure port 3214 is not being used by another service
- Try restarting the add-on

### Permission Errors

- Adjust `puid` and `pgid` to match your Home Assistant user
- Default values (1000) work for most installations
- Check directory permissions if using external folders

### Database Connection Issues

For external databases:
- Verify the database server is running
- Check network connectivity
- Confirm credentials are correct
- Ensure the database exists and user has permissions

### Library Not Scanning

- Verify the path exists and is accessible
- Check file permissions
- Look at add-on logs for specific errors
- Try creating a test file in the directory

### Files Not Appearing

- Click the **Scan** button in the library settings
- Supported formats: STL, OBJ, 3MF, PLY, and more
- Check that files aren't corrupted
- Review the add-on logs

## Advanced Configuration

### Using External Database for Better Performance

For larger collections (1000+ models), consider using PostgreSQL:

1. Install PostgreSQL (via another add-on or external server)
2. Create a database: `CREATE DATABASE manyfold;`
3. Create a user with permissions
4. Configure the add-on with database details
5. Restart the add-on

### Custom Theme

Manyfold supports multiple themes! Change in Settings → Appearance after logging in.

### Backup and Restore

#### Automatic Backups

Home Assistant backups include:
- Add-on configuration
- Database (if using SQLite)
- Settings and preferences

#### Manual Backups

For external databases, use your database's backup tools.

For model files:
- Your actual model files should be backed up separately
- They're typically in `/share/3dmodels` or your configured path
- Use Home Assistant's backup features or external backup tools

## Support and Resources

- **Manyfold Documentation**: https://manyfold.app
- **Manyfold GitHub**: https://github.com/manyfold3d/manyfold
- **Report Issues**: Use the GitHub Issues for this add-on repository
- **Home Assistant Community**: https://community.home-assistant.io

## Credits

- **Manyfold** by James Smith (@Floppy) and contributors
- Docker images built with [Depot](https://depot.dev)
- This add-on packages Manyfold for easy use in Home Assistant

## License

This add-on is released under the MIT License.

Manyfold itself is open source under the MIT License.

---

**Enjoying this add-on?** Consider:
- ⭐ Starring the [Manyfold repository](https://github.com/manyfold3d/manyfold)
- 💝 [Donating to support Manyfold development](https://manyfold.app/donate)
- 📢 Sharing with the 3D printing community
