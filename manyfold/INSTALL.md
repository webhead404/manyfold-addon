# Installation Guide for Manyfold Home Assistant Add-on

This guide will walk you through installing and setting up the Manyfold add-on for Home Assistant.

## Prerequisites

Before you begin, ensure you have:

- Home Assistant OS, Supervised, or Container installation
- Access to the Supervisor tab (add-ons are not available on Home Assistant Core)
- At least 1GB of free storage space
- Internet connection for downloading the add-on

## Installation Steps

### Step 1: Add the Repository

1. Open your Home Assistant instance
2. Navigate to **Settings** → **Add-ons**
3. Click the **Add-on Store** button (bottom right)
4. Click the **⋮** menu (three dots in top right corner)
5. Select **Repositories**
6. Add this repository URL:
   ```
   https://github.com/YOUR_USERNAME/hassio-addons
   ```
7. Click **Add**
8. Close the dialog

### Step 2: Install the Add-on

1. The add-on store should now refresh
2. Scroll down to find **Manyfold** in the list
   - It should appear under the repository name you just added
3. Click on **Manyfold**
4. Click the **Install** button
5. Wait for the installation to complete (this may take several minutes)
   - The add-on will download the Manyfold container image
   - Initial download is around 500MB-1GB depending on architecture

### Step 3: Configure the Add-on (Optional)

Before starting, you can customize the configuration:

1. Click on the **Configuration** tab
2. Modify settings as needed (see Configuration section below)
3. Click **Save**

**Basic configuration (works for most users):**
```yaml
database_type: sqlite
puid: 1000
pgid: 1000
```

### Step 4: Start the Add-on

1. Go to the **Info** tab
2. Toggle **Start on boot** if you want Manyfold to start automatically
3. Toggle **Watchdog** to automatically restart if it crashes
4. Click **Start**
5. Wait for the add-on to start (check the **Log** tab for progress)

### Step 5: Access Manyfold

Once started, you can access Manyfold in several ways:

**Option 1: Open Web UI Button**
- Click the **OPEN WEB UI** button in the add-on info page
- This opens Manyfold at `http://homeassistant.local:3214`

**Option 2: Direct URL**
- Open a browser and go to: `http://YOUR_HA_IP:3214`
- Replace `YOUR_HA_IP` with your Home Assistant IP address

**Option 3: Add to Sidebar (Recommended)**
- In the add-on Info tab, enable **Show in sidebar**
- Manyfold will appear in your Home Assistant sidebar

## Initial Setup

### First Time Login

1. Open the Manyfold web interface
2. You'll be prompted to create an administrator account
3. Enter:
   - **Username**: Your desired admin username
   - **Email**: Your email address (used for notifications if enabled)
   - **Password**: A strong password
4. Click **Create Account**

### Create Your First Library

1. After logging in, go to **Settings** (gear icon)
2. Click on **Libraries** in the left sidebar
3. Click **New Library**
4. Enter library details:
   - **Name**: A descriptive name (e.g., "3D Models", "STL Files")
   - **Path**: Directory path where your models are stored
     - Recommended: `/share/3dmodels`
     - Other options: `/media/3dmodels`, `/config/3dmodels`
5. Click **Create**

### Upload Your First Models

**Method 1: Via Samba/Network Share**

1. Install the **Samba share** add-on from the Home Assistant add-on store
2. Connect to your Home Assistant via network share:
   - Windows: `\\homeassistant.local\share`
   - Mac: `smb://homeassistant.local/share`
   - Linux: `smb://homeassistant.local/share`
3. Create the `3dmodels` folder if it doesn't exist
4. Copy your STL/3MF/OBJ files into this folder

**Method 2: Via SSH**

1. Install the **Terminal & SSH** add-on
2. Open a terminal
3. Create directory: 
   ```bash
   mkdir -p /share/3dmodels
   ```
4. Upload files via SCP:
   ```bash
   scp *.stl root@homeassistant.local:/share/3dmodels/
   ```

**Method 3: Via Web Interface**

1. In Manyfold, navigate to your library
2. Click the **Upload** button
3. Drag and drop files or click to browse
4. Wait for upload and processing to complete

### Scan Your Library

1. Go to **Settings** → **Libraries**
2. Click on your library name
3. Click the **Scan** button
4. Wait for the scan to complete
5. Return to the home page to see your models

## Configuration Details

### Database Options

#### SQLite (Default - Recommended)

Best for most users with under 1000 models:

```yaml
database_type: sqlite
puid: 1000
pgid: 1000
```

**Pros:**
- No external database needed
- Simple setup
- Automatic backups with Home Assistant
- Good performance for small/medium collections

**Cons:**
- Slower with very large collections (5000+ models)
- Limited concurrent user support

#### PostgreSQL

Best for large collections or multiple users:

```yaml
database_type: postgresql
database_host: 192.168.1.100
database_port: 5432
database_name: manyfold
database_user: manyfold
database_password: "your-secure-password-here"
puid: 1000
pgid: 1000
```

**Setup PostgreSQL:**

1. Install PostgreSQL (via add-on or external server)
2. Create database:
   ```sql
   CREATE DATABASE manyfold;
   CREATE USER manyfold WITH PASSWORD 'your-password';
   GRANT ALL PRIVILEGES ON DATABASE manyfold TO manyfold;
   ```
3. Configure add-on with these credentials
4. Restart the add-on

#### MySQL/MariaDB

Alternative to PostgreSQL:

```yaml
database_type: mysql
database_host: 192.168.1.100
database_port: 3306
database_name: manyfold
database_user: manyfold
database_password: "your-secure-password-here"
puid: 1000
pgid: 1000
```

### Multiuser Mode

Enable multiple user accounts:

```yaml
database_type: sqlite
puid: 1000
pgid: 1000
multiuser_enabled: true
registration_enabled: false  # Set to true to allow signups
```

When enabled:
- Users can have private libraries
- Share models publicly or privately
- Set per-user permissions
- Federation features become available

### File Permissions

```yaml
puid: 1000  # User ID
pgid: 1000  # Group ID
```

**When to change:**
- If you have permission issues accessing files
- If using external storage with specific ownership
- Default (1000) works for most Home Assistant installations

**How to find your values:**
1. SSH into Home Assistant
2. Run: `id`
3. Use the `uid` and `gid` values shown

## Directory Structure

After installation, create this recommended structure:

```
/share/
  └── 3dmodels/
      ├── miniatures/
      │   ├── D&D/
      │   └── Warhammer/
      ├── functional/
      │   ├── organizers/
      │   └── tools/
      ├── artistic/
      └── prototypes/
```

Manyfold will scan all subdirectories automatically.

## Troubleshooting Installation

### Add-on Not Installing

**Check available storage:**
```bash
df -h
```
Ensure you have at least 1GB free.

**Check internet connection:**
Verify Home Assistant can reach the internet to download images.

**Check logs:**
1. Go to **Settings** → **System** → **Logs**
2. Look for supervisor errors

### Add-on Won't Start

**Check the logs:**
1. Go to the add-on page
2. Click the **Log** tab
3. Look for error messages

**Common issues:**
- Port 3214 already in use
- Database connection failed
- Permission issues

**Solutions:**
- Restart Home Assistant
- Check configuration is valid YAML
- Verify database credentials
- Check file permissions

### Can't Access Web UI

**Verify add-on is running:**
- Check status shows "Started"
- Green indicator on Info tab

**Try different URLs:**
- `http://homeassistant.local:3214`
- `http://YOUR_IP:3214`
- Check your Home Assistant IP address

**Check firewall:**
Ensure port 3214 isn't blocked by a firewall.

**Clear browser cache:**
Try hard refresh (Ctrl+Shift+R) or incognito mode.

## Next Steps

After successful installation:

1. **Organize your models** with tags and collections
2. **Set up backups** (automatically included in HA backups)
3. **Explore features** like the 3D viewer and search
4. **Configure themes** in Settings → Appearance
5. **Enable federation** to connect with other instances (optional)
6. **Check for updates** regularly in the add-on page

## Getting Help

If you encounter issues:

1. Check the **Logs** tab in the add-on
2. Search [GitHub Issues](https://github.com/manyfold3d/manyfold/issues)
3. Visit [Home Assistant Community Forums](https://community.home-assistant.io)
4. Check [Manyfold Documentation](https://manyfold.app)
5. Join the [Matrix Chat](https://matrix.to/#/#manyfold:matrix.org)

## Updating the Add-on

Updates will appear automatically in the Add-on Store:

1. Go to **Settings** → **Add-ons**
2. Look for update badge on Manyfold
3. Click the add-on
4. Click **Update**
5. Review changelog
6. Wait for update to complete
7. Restart if required

**Before major updates:**
- Create a full Home Assistant backup
- Export important data if needed
- Check changelog for breaking changes

---

Congratulations! You now have Manyfold running in Home Assistant. Enjoy organizing your 3D printing model library! 🎉
