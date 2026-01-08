# Homebox Add-on Installation Guide

## Prerequisites

- Home Assistant OS, Supervised, Container, or Core
- Internet connection to download add-on

## Step-by-Step Installation

### 1. Add Repository to Home Assistant

1. Open Home Assistant
2. Go to **Settings** → **Add-ons** → **Add-on Store**
3. Click the **⋮** (three dots) menu in the top right
4. Click **Repositories**
5. Add this URL: `https://github.com/YOUR_USERNAME/hassio-addons-homebox`
6. Click **Add**
7. Close the repositories dialog

### 2. Install Homebox Add-on

1. Refresh the add-on store page
2. Find **Homebox** in the list
3. Click on it
4. Click **Install**
5. Wait for installation (may take 1-2 minutes)

### 3. Configure (Optional)

Click the **Configuration** tab:

```yaml
log_level: info
max_upload_size: 10
allow_registration: true
```

- **log_level**: How detailed logs should be (debug/info/warn/error)
- **max_upload_size**: Maximum file size for photos in MB
- **allow_registration**: Allow new users to sign up

**Recommendation**: Leave defaults for first time, change later if needed.

### 4. Start the Add-on

1. Go to the **Info** tab
2. Toggle **Start on boot** (optional but recommended)
3. Click **Start**
4. Watch the **Log** tab - should see "Homebox initialization complete"

### 5. Access Homebox

1. Click **OPEN WEB UI** button
2. Or visit: `http://homeassistant.local:7745`

### 6. Create Your Account

1. First time you visit, you'll see a registration form
2. Fill in:
   - **Email** - Your email (used for login)
   - **Username** - Display name
   - **Password** - Choose a strong password
   - **Name** - Your full name (optional)
3. Click **Create Account**
4. You're automatically logged in!

### 7. Secure Your Instance

**Important**: After creating your account(s), disable registration!

1. Go to add-on **Configuration** tab
2. Set `allow_registration: false`
3. Click **Save**
4. **Restart** the add-on

This prevents unauthorized users from creating accounts.

## Quick Start Guide

### Create Locations

1. Click on **Locations** in the sidebar
2. Click **Create**
3. Add locations like:
   - Living Room
   - Kitchen
   - Bedroom
   - Garage
   - Storage Unit

You can create hierarchies: House → Living Room → Bookshelf

### Create Labels

1. Click on **Labels** in the sidebar
2. Click **Create**
3. Add labels like:
   - Electronics
   - Furniture
   - Important Documents
   - Collectibles
   - Tools

Use colors to make them visually distinct!

### Add Your First Item

1. Click **Items** → **Create**
2. Fill in:
   - **Name**: What is it? (e.g., "Samsung 55\" TV")
   - **Description**: Details (optional)
   - **Location**: Where is it?
   - **Labels**: What category?
3. **Add a photo** (highly recommended!)
4. Add purchase info if you have it:
   - Purchase date
   - Purchase price
   - Store/Retailer
5. Click **Create**

### Add More Details (Optional)

For each item you can also add:
- **Serial Number** - For electronics
- **Model Number** - Product identification
- **Warranty Expiration** - Get reminders
- **Notes** - Any additional info
- **Attachments** - Receipts, manuals, etc.

## Tips for Getting Started

### Start Small
Don't try to inventory everything at once! Start with:
1. One room
2. Valuable items first
3. Items you need for insurance

### Take Photos
Photos are incredibly valuable for:
- Visual identification
- Insurance claims
- Remembering what you own
- Selling items later

### Use Consistent Naming
- "Samsung 55\" TV" vs "tv samsung"
- "MacBook Pro 16\"" vs "laptop"
- Consistency makes searching easier!

### Organize Thoughtfully
- **Locations** = WHERE it is physically
- **Labels** = WHAT TYPE it is

Example: A toaster is:
- Location: Kitchen → Counter
- Labels: Electronics, Small Appliance

## Troubleshooting

### Add-on Won't Start

Check the logs (Info → Log tab):
- Look for error messages
- Common issues:
  - Port 7745 already in use
  - Insufficient disk space
  - Corrupted data directory

### Can't Access Web UI

1. Make sure add-on shows "Started" (green)
2. Wait 30 seconds after starting
3. Try direct: `http://homeassistant.local:7745`
4. Check Home Assistant is accessible
5. Check logs for errors

### Forgot Password

Currently no password reset. You'll need to either:
1. Create new account (if registration enabled)
2. Access database directly (advanced)

**Prevention**: Use a password manager!

### Registration Button Missing

If you set `allow_registration: false`, this is intentional!

To add more users:
1. Temporarily set to `true`
2. Restart add-on
3. Register new accounts
4. Set back to `false`

Or use the admin interface:
- Settings → Users → Invite

## Updating

When a new version is released:

1. Go to add-on Info tab
2. If update available, you'll see "Update" button
3. Click **Update**
4. Wait for update to complete
5. Restart add-on

Your data is preserved during updates!

## Backing Up

### Automatic (Recommended)

Home Assistant backups include add-on data:

1. Settings → System → Backups
2. Click **Create Backup**
3. Select what to include
4. Click **Create**

### Manual Backup

```bash
# SSH to Home Assistant
cd /mnt/data/supervisor/addons/data
tar -czf homebox-backup-$(date +%Y%m%d).tar.gz slug_homebox/
```

Download this file and store somewhere safe!

## Uninstalling

If you need to remove Homebox:

1. **Backup your data first!** (See above)
2. Go to add-on Info tab
3. Click **Uninstall**
4. Confirm

**Warning**: This will delete all your data unless you backed up!

## Next Steps

- Read the **DOCS** tab for detailed usage
- Visit https://homebox.software/ for more info
- Join Home Assistant community forums for support

Happy organizing! 📦

---

## Need Help?

- Check the **Log** tab for errors
- Read **DOCS** tab for usage help
- Visit https://homebox.software/
- GitHub Issues: https://github.com/sysadminsmedia/homebox/issues
