# Homebox Add-on Documentation

## What is Homebox?

Homebox is a home inventory and organization system that helps you track everything you own. Perfect for:

- Home insurance documentation
- Warranty tracking
- Organization and decluttering
- Estate planning
- Moving/relocation
- Sharing items with family

## Quick Start

1. **Create your account**
   - First user automatically becomes admin
   - **Important**: Disable registration after creating accounts (Configuration tab)

2. **Set up locations**
   - Think of locations as physical places (rooms, storage areas, etc.)
   - Create a hierarchy: House → Living Room → Entertainment Center
   - Add as many or as few as you need

3. **Create labels**
   - Labels are categories or tags
   - Examples: Electronics, Furniture, Kitchen, Collectibles
   - Use colors to make them easy to identify

4. **Start adding items**
   - Click "Create Item"
   - Fill in as much or as little detail as you want
   - Add photos (highly recommended!)
   - Assign to locations and labels

## Configuration Options

### Log Level
Controls how much detail appears in logs:
- **debug** - Very detailed (for troubleshooting)
- **info** - Normal detail (recommended)
- **warn** - Only warnings and errors
- **error** - Only errors

### Max Upload Size
Maximum file size for attachments in MB. Default is 10MB.

Larger values allow bigger photos/PDFs but use more storage:
- 10MB - Good for most photos
- 25MB - Good for high-res photos
- 50MB - For documents and manuals

### Allow Registration
**Important security setting!**

- **true** - Anyone can create an account
- **false** - Registration is disabled

**Recommended**: Set to `true` initially to create accounts, then set to `false` to prevent unauthorized access.

## Using Homebox

### Items

The core of Homebox. Each item can have:

- **Name & Description** - What it is
- **Photos** - Visual identification
- **Location** - Where it's stored
- **Labels** - Categories/tags
- **Purchase Info** - Date, price, store
- **Warranty** - Expiration date
- **Serial Number** - For electronics
- **Model Number** - Product identification
- **Notes** - Any additional info
- **Attachments** - Receipts, manuals, etc.

### Locations

Organize items by physical location:

```
House
├── Kitchen
│   ├── Pantry
│   └── Drawers
├── Living Room
│   ├── Bookshelf
│   └── Entertainment Center
└── Garage
    └── Tool Cabinet
```

### Labels

Tag items with multiple labels:
- **Electronics** - TVs, computers, etc.
- **Furniture** - Sofas, tables, beds
- **Important** - Valuable or sentimental items
- **Warranty** - Items still under warranty
- **Sell** - Items you're planning to sell

### QR Codes

Generate QR code labels for physical items:

1. Open an item
2. Click "Generate QR Code"
3. Print the QR code
4. Attach to the physical item
5. Scan with phone to instantly view in Homebox!

Great for storage boxes, equipment, tools, etc.

### Search

Use the search bar to find items by:
- Name
- Description
- Serial number
- Location
- Label
- Notes

## Best Practices

### For Insurance Documentation

1. **Take clear photos** - Front, back, serial numbers
2. **Save receipts** - Attach as PDF or photo
3. **Record values** - Purchase price and current value
4. **Update regularly** - Review annually
5. **Export backups** - Keep a backup off-site

### For Organization

1. **Start small** - One room at a time
2. **Be consistent** - Use similar naming patterns
3. **Use locations** - Physical organization helps
4. **Add as you go** - When buying new items, add immediately
5. **Regular maintenance** - Update when moving/selling items

### For Warranties

1. **Add warranty dates** - Get reminded before expiration
2. **Attach receipts** - Proof of purchase
3. **Note coverage** - What's covered and what's not
4. **Save contact info** - Manufacturer support details

## Data & Privacy

### Where is data stored?

All data stays on your Home Assistant server:
- Database: `/data/homebox.db` (SQLite)
- Photos/Attachments: `/data/attachments/`

### Backing up

Homebox is included in Home Assistant backups. For extra safety:

1. Settings → System → Backups
2. Create backup regularly
3. Download backup to external storage

### Multi-User

Homebox supports multiple users in groups:
- All users in a group see the same items
- Perfect for families
- Each user has their own login
- Invite users via Settings → Users

## Troubleshooting

### Can't upload photos

1. Check **max_upload_size** in configuration
2. Ensure photo is under the size limit
3. Try compressing the photo
4. Check available storage space

### Registration button missing

If you set `allow_registration: false`, the registration button won't appear. This is intentional for security.

To add users:
1. Temporarily set `allow_registration: true`
2. Save and restart add-on
3. Create accounts
4. Set back to `false`

Or invite users via Settings → Users (if you're admin).

### Items not showing up

1. Check you're in the correct group
2. Try refreshing the page
3. Check filters (top of page)
4. Use search to find specific items

### Forgot password

Currently no password reset feature. You'll need to:
1. Access the database directly (advanced)
2. Or create a new account and re-enter data

Recommendation: Use a password manager!

## Tips & Tricks

### Quick Item Entry

Don't feel obligated to fill every field! Start with:
1. Name
2. Location  
3. Photo (optional but recommended)

Add more details later as needed.

### Bulk Operations

Use labels and locations to manage items in bulk:
- "Moving" label for items being relocated
- "Donate" label for items to give away
- "Sell" label for items to list online

### Mobile Access

Access Homebox from your phone:
1. Open Home Assistant app
2. Go to add-ons
3. Click Homebox → Open Web UI

Or access directly: `http://homeassistant.local:7745`

### Categories vs Locations

- **Locations** = WHERE it is physically
- **Labels** = WHAT TYPE it is

Example: A toaster is:
- Location: Kitchen → Counter
- Labels: Electronics, Small Appliance

## Need Help?

- **Documentation**: https://homebox.software/
- **GitHub Issues**: https://github.com/sysadminsmedia/homebox/issues
- **Community**: Home Assistant forums

---

Happy organizing! 📦
