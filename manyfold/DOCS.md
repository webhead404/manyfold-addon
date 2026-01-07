# Manyfold Add-on Documentation

## What is Manyfold?

Manyfold is a self-hosted digital asset manager specifically designed for 3D print files. It helps you organize, view, and share your collection of 3D models with features like:

- Interactive 3D model viewer
- Smart tagging and organization
- Full-text search across your library
- Multi-library support
- ActivityPub federation (connect with other instances)
- Privacy-focused (all data stays on your server)

## First-Time Setup

⚠️ **CRITICAL REQUIREMENTS:**

1. **Use specific paths, NOT parent directories!**
   - ❌ **WRONG:** Using `/media/` will scan your entire media folder
   - ✅ **CORRECT:** Use `/media/3dprint-library`

2. **⚠️ FILES MUST BE IN FOLDERS!** Manyfold expects each model in its own folder:
   
   **✅ CORRECT Structure:**
   ```
   /media/3dprint-library/
     ├── octopus/
     │   └── octopus.stl
     ├── dragon/
     │   └── dragon.stl
     └── terrain/
         └── rock.stl
   ```
   
   **❌ WRONG - Files won't be detected:**
   ```
   /media/3dprint-library/
     ├── octopus.stl      ← Files at root level won't scan!
     ├── dragon.stl       ← Put them in folders!
     └── rock.stl
   ```

After starting the add-on:

1. Click "Open Web UI"
2. Create an admin account (first user becomes admin)
3. **Add a library:**
   - Go to Settings → Libraries
   - Click "New Library"
   - **Name:** "3D Models" (or any name you prefer)
   - **Path:** Enter the EXACT path from your add-on configuration
     - If your config has `library_path: /media/3dprint-library`
     - Then enter `/media/3dprint-library` in Manyfold
   - **Storage service:** File system
   - ⚠️ **UNCHECK "Create directory if it doesn't exist"** - the add-on already created it
   - ⚠️ **VERIFY the path is correct** before clicking Create
   - Click Create
4. **Upload models:**
   - Via Samba: `\\homeassistant.local\media\3dprint-library`
   - Or drag-and-drop in Manyfold web UI
5. Click "Scan Library" to import files
5. Click "Scan Library" to import existing files

## Configuration

### Library Path

```yaml
library_path: /media/3dprint-library
```

**Important Notes:**
- The add-on creates this directory automatically
- When adding the library in Manyfold, use this EXACT path
- Do NOT use just `/media` - that's the entire media folder
- Do NOT check "create directory" in Manyfold - it's already created
- The path must be absolute (starting with `/`)

### Common Library Paths

```yaml
# Recommended (default)
library_path: /media/3dprint-library

# Alternative options
library_path: /share/models
library_path: /media/stl-files
library_path: /share/3d-prints
```

**Accessible via Samba:**
- `/media/X` → `\\homeassistant.local\media\X`
- `/share/X` → `\\homeassistant.local\share\X`

## Configuration

### Library Path

```yaml
library_path: /media/HA-USB/3dprint-library
```

**Important:** This is the **Docker container path**, not the host path!

#### Understanding Path Mapping

Home Assistant automatically maps directories:

| Host Path (Home Assistant OS) | Container Path (Manyfold sees) |
|-------------------------------|--------------------------------|
| `/mnt/data/supervisor/media/` | `/media/` |
| `/mnt/data/supervisor/share/` | `/share/` |

**Example:**
- Host: `/mnt/data/supervisor/media/HA-USB/3dprint-library`
- Container: `/media/HA-USB/3dprint-library` ← Use this in config!

The `library_path` should be the **container path** (starting with `/media/` or `/share/`).

### How to Add Your Library

After starting the add-on:

1. Click "Open Web UI"
2. Create admin account (first user)
3. **Settings** → **Libraries** → **New Library**
4. Configure the library:
   - **Name**: "My 3D Models" (or whatever you prefer)
   - **Path**: Use the EXACT path from your config (e.g., `/media/HA-USB/3dprint-library`)
   - **Storage Service**: File system
   - ⚠️ **UNCHECK "Create directory"** - it already exists!
5. Click "Create Library"
6. Your library is now ready!

### Common Mistake to Avoid

❌ **DON'T** add `/media/` as the library path - this will scan everything in your media folder!

✅ **DO** use the specific subdirectory: `/media/3dprint-library`

### Multiple Libraries

You can create multiple libraries by:

1. Using subdirectories under your library_path:
   ```
   /media/3dprint-library/terrain
   /media/3dprint-library/miniatures
   /media/3dprint-library/functional
   ```

2. Adding each subdirectory as a separate library in Manyfold

Or configure different paths:
```yaml
library_path: /media/models
```

Then create subdirectories and add them individually.

**SQLite (Recommended for most users)**
```yaml
database_type: sqlite
```
- Simplest setup, no external database needed
- Perfect for personal use and small to medium collections
- Data stored in `/data/manyfold.db`

**PostgreSQL (For large collections)**
```yaml
database_type: postgresql
database_host: 192.168.1.100
database_port: 5432
database_name: manyfold
database_user: manyfold
database_password: your-password
```
- Better performance for 1000+ models
- Requires external PostgreSQL server

**MySQL**
```yaml
database_type: mysql
database_host: 192.168.1.100
database_port: 3306
database_name: manyfold
database_user: manyfold
database_password: your-password
```
- Alternative to PostgreSQL
- Requires external MySQL/MariaDB server

### File Permissions

```yaml
puid: 1000
pgid: 1000
```

Set these to match your Home Assistant user/group for proper file access. Default values work for most installations.

**To find your user ID:**
```bash
id -u  # Shows PUID
id -g  # Shows PGID
```

Setting these correctly prevents the "running as root" security warning.

### Library Path

```yaml
library_path: /media/3dprint-library
```

Configure where your 3D model files will be stored. The directory will be created automatically if it doesn't exist. This makes it easy to access your models via Samba at `\\homeassistant.local\media\3dprint-library`.

Other common paths:
- `/media/3dprint-library` (default) - Accessible via Samba media share
- `/share/models` - Accessible via Samba share folder
- `/config/models` - In your config directory

### Multiuser Mode

```yaml
multiuser_enabled: true
registration_enabled: true
```

Enable if you want:
- Multiple user accounts
- User registration (or invite-only if `registration_enabled: false`)
- Public/private model sharing
- User-specific libraries

### Model Library Paths

Common paths you can use:
- `/share/3dmodels` - Files in Home Assistant's share directory
- `/media/3dmodels` - Files in the media directory  
- `/config/3dmodels` - Files in the config directory
- `/addons` - Read-only access to add-ons directory

Create these directories before adding them as libraries.

## Uploading Models

### Via Samba Share

1. Install the "Samba share" add-on
2. Connect to `\\homeassistant.local\share`
3. Create a folder (e.g., `3dmodels`)
4. Copy your STL, 3MF, OBJ files there

### Via SSH

1. Install "Terminal & SSH" add-on
2. Run: `mkdir -p /share/3dmodels`
3. Upload via SCP: `scp model.stl root@homeassistant.local:/share/3dmodels/`

### Via Web UI

1. Open Manyfold web interface
2. Navigate to your library
3. Click "Upload" button
4. Drag and drop files or select from browser

## Supported File Formats

### 3D Models
STL, OBJ, 3MF, PLY, AMF, FBX, COLLADA (DAE), glTF, GLB, 3DS

### Images
PNG, JPG, JPEG, GIF, WebP

### Documents
PDF, Markdown (MD), Text (TXT)

### Archives
ZIP files (automatically extracted)

### Other
Gerber files, KiCad projects

## Tips and Best Practices

### Organizing Your Collection

1. **Use Collections**: Group related models together (e.g., "Chess Set", "Robot Parts")
2. **Tag Everything**: Add descriptive tags for easy searching
3. **Add Creators**: Track who designed each model
4. **Set Licenses**: Document model licenses for proper attribution
5. **Add Notes**: Include printing tips, settings, or project details

### Performance Tips

- Use PostgreSQL for collections over 1000 models
- Keep model files on SSD storage when possible
- Regularly scan libraries to keep index updated
- Delete unused models to save space

### Backup Strategy

1. **Add-on Configuration**: Included in Home Assistant backups
2. **Database**: Included if using SQLite; backup separately for PostgreSQL/MySQL
3. **Model Files**: Backup your `/share/3dmodels` directory regularly
4. **Consider automation**: Use Home Assistant automations to backup to NAS/cloud

### Integration Ideas

**With OctoPrint/Printer Add-on**
- Browse models in Manyfold
- Download directly to your slicer
- Track which models you've printed

**With Node-RED**
- Automate model organization
- Create workflows for new uploads
- Notify when new models are added

**With File Sensors**
- Monitor library size
- Track model additions
- Alert on storage space

## Troubleshooting

### Cannot Access Web UI

**Check add-on status**: Ensure it's running and shows "Started"

**Check logs**: Look for errors in the add-on log tab

**Port conflict**: Make sure port 3214 isn't used elsewhere

**Restart add-on**: Sometimes a restart resolves issues

### Library Not Scanning

**Verify path**: Ensure the directory exists and is accessible

**Check permissions**: Verify PUID/PGID settings match your files

**Manual scan**: Click the "Scan" button in library settings

**Check logs**: Look for permission or path errors

### Models Not Displaying

**Supported format**: Verify file is a supported 3D format

**File corruption**: Try opening the file in another 3D viewer

**Refresh browser**: Clear cache and reload

**Check previews**: Some formats may take time to generate previews

### Database Errors

**SQLite**: Ensure `/data` has write permissions

**PostgreSQL/MySQL**: 
- Verify database server is running
- Check credentials are correct
- Ensure database exists
- Test network connectivity

### Permission Issues

**Check PUID/PGID**: Should match Home Assistant user (usually 1000)

**Verify directory ownership**: Files should be accessible by the specified user

**SELinux/AppArmor**: May require adjustments on some systems

## Advanced Features

### Federation (ActivityPub)

Connect your Manyfold instance to the Fediverse:

1. Enable in Settings → Federation
2. Set your instance domain
3. Follow other Manyfold instances
4. Share public models
5. Discover models from the community

### API Access

Manyfold includes a REST API at `/api`:
- Access model data programmatically
- Build custom integrations
- Automate workflows
- See `/api` endpoint for documentation

### Custom Themes

Choose from 26+ themes:
- Navigate to Settings → Appearance
- Select your preferred theme
- Changes apply immediately

## Getting Help

- **Documentation**: https://manyfold.app
- **GitHub Issues**: Report bugs and request features
- **Matrix Chat**: Join the Manyfold community
- **Home Assistant Forums**: Community support

## Updating

Updates are handled through Home Assistant's add-on system:

1. Navigate to Add-ons
2. Click on Manyfold
3. If an update is available, click "Update"
4. Check changelog for breaking changes
5. Backup before major version updates

## Security Considerations

- Change default ports if exposing to internet
- Use strong passwords in multiuser mode
- Keep add-on updated
- Regular backups of data
- Consider using Nginx Proxy Manager for SSL
- Restrict network access as needed

## Resource Usage

**Typical Requirements:**
- RAM: 512MB - 2GB (depending on library size)
- Storage: Varies by model collection size
- CPU: Minimal when idle, moderate during scans

**Recommended Hardware:**
- Raspberry Pi 4 (4GB) or better
- SSD storage for better performance
- Adequate storage for your model collection
