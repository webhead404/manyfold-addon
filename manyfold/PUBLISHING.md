# Publishing Your Manyfold Add-on

This guide explains how to publish this add-on so others (or you) can install it in Home Assistant.

## Overview

Home Assistant add-ons are distributed through Git repositories. Users add your repository URL to their Home Assistant instance, and the add-on becomes available in their add-on store.

## Prerequisites

- GitHub account (or GitLab, Bitbucket, etc.)
- Git installed locally
- Basic knowledge of Git commands

## Step-by-Step Publishing Guide

### Step 1: Create a Repository

1. Go to [GitHub](https://github.com)
2. Click **New Repository**
3. Name it something like: `hassio-addons` or `ha-manyfold-addon`
4. Make it **Public** (required for others to access)
5. Initialize with a README (optional)
6. Click **Create Repository**

### Step 2: Prepare the Repository Structure

Your repository should have this structure:

```
hassio-addons/
├── manyfold/
│   ├── config.yaml
│   ├── Dockerfile
│   ├── build.yaml
│   ├── README.md
│   ├── DOCS.md
│   ├── CHANGELOG.md
│   ├── icon.png (optional)
│   ├── logo.png (optional)
│   └── rootfs/
│       └── etc/
│           └── services.d/
│               └── manyfold/
│                   └── run
├── repository.json
└── README.md
```

### Step 3: Upload Files to GitHub

**Option A: Via Git Command Line**

```bash
# Navigate to your add-on directory
cd /home/claude/manyfold-addon

# Initialize git repository
git init

# Add all files
git add .

# Commit files
git commit -m "Initial commit: Manyfold Home Assistant Add-on"

# Add your GitHub repository as remote
git remote add origin https://github.com/YOUR_USERNAME/hassio-addons.git

# Push to GitHub
git branch -M main
git push -u origin main
```

**Option B: Via GitHub Web Interface**

1. Go to your repository on GitHub
2. Click **Add file** → **Upload files**
3. Drag and drop all files from the manyfold-addon directory
4. Keep the folder structure intact
5. Click **Commit changes**

### Step 4: Update repository.json

Edit `repository.json` with your information:

```json
{
  "name": "Manyfold Add-on Repository",
  "url": "https://github.com/YOUR_USERNAME/hassio-addons",
  "maintainer": "Your Name <your.email@example.com>"
}
```

Commit this change.

### Step 5: Test the Repository

Before sharing publicly, test it yourself:

1. Open Home Assistant
2. Go to **Settings** → **Add-ons** → **Add-on Store**
3. Click **⋮** (three dots) → **Repositories**
4. Add your repository URL:
   ```
   https://github.com/YOUR_USERNAME/hassio-addons
   ```
5. Click **Add**
6. Look for Manyfold in the add-on store
7. Try installing and running it

### Step 6: Add Icons (Optional but Recommended)

Create or download icons for your add-on:

**icon.png**: 
- 256x256 pixels
- Shows in add-on list
- PNG format

**logo.png**:
- Flexible size (512x512 recommended)
- Shows on add-on detail page
- PNG format

You can use the Manyfold logo or create your own. Place these files in the `manyfold/` directory.

### Step 7: Write a Repository README

Create a `README.md` in the repository root:

````markdown
# Home Assistant Add-ons Repository

This repository contains Home Assistant add-ons maintained by [Your Name].

## Add-ons

### Manyfold

![Manyfold Logo](manyfold/logo.png)

A self-hosted digital asset manager for 3D print files.

**Features:**
- Interactive 3D model viewer
- Smart organization with tags and collections
- Full-text search
- ActivityPub federation
- Privacy-first design

[Open add-on documentation](manyfold/README.md)

## Installation

Add this repository to your Home Assistant instance:

1. Navigate to **Settings** → **Add-ons** → **Add-on Store**
2. Click **⋮** (menu) → **Repositories**
3. Add: `https://github.com/YOUR_USERNAME/hassio-addons`
4. Find and install **Manyfold**

## Support

- [Report Issues](https://github.com/YOUR_USERNAME/hassio-addons/issues)
- [Manyfold Documentation](https://manyfold.app)
- [Home Assistant Forums](https://community.home-assistant.io)

## Credits

- [Manyfold](https://github.com/manyfold3d/manyfold) by @Floppy
- Add-on maintained by [Your Name]

## License

MIT License - See individual add-ons for details
````

### Step 8: Create Releases (Optional but Recommended)

Using GitHub releases helps users track versions:

1. Go to your repository on GitHub
2. Click **Releases** → **Create a new release**
3. Tag version: `v1.0.0`
4. Release title: `Manyfold Add-on v1.0.0`
5. Description: Copy from CHANGELOG.md
6. Click **Publish release**

### Step 9: Share Your Add-on

Now that it's published, share it:

**Home Assistant Community Forums:**
1. Go to [community.home-assistant.io](https://community.home-assistant.io)
2. Post in the "Third-party Add-ons" category
3. Include:
   - Description of Manyfold
   - Installation instructions
   - Link to your repository
   - Screenshots if possible

**Reddit:**
- Post to [r/homeassistant](https://reddit.com/r/homeassistant)
- Share your repository and experience

**GitHub:**
- Star the original [Manyfold repository](https://github.com/manyfold3d/manyfold)
- Consider mentioning the add-on in a discussion

## Maintenance

### Keeping Up-to-Date

When Manyfold releases updates:

1. Check [Manyfold releases](https://github.com/manyfold3d/manyfold/releases)
2. Update version in `config.yaml`
3. Update `CHANGELOG.md`
4. Test the new version
5. Commit and push changes
6. Create new GitHub release
7. Users will see update available in their add-on store

### Handling Issues

When users report issues:

1. Check the issue on GitHub
2. Try to reproduce the problem
3. Check Manyfold's issue tracker for related issues
4. Provide logs and troubleshooting steps
5. Update documentation if needed

### Best Practices

**Versioning:**
- Use semantic versioning (MAJOR.MINOR.PATCH)
- Increment MAJOR for breaking changes
- Increment MINOR for new features
- Increment PATCH for bug fixes

**Documentation:**
- Keep README and DOCS updated
- Add troubleshooting tips as issues arise
- Include examples and screenshots
- Update CHANGELOG for each release

**Testing:**
- Test on different architectures if possible
- Verify upgrades work smoothly
- Check resource usage
- Test backup and restore

## Advanced: Submit to Home Assistant Community Add-ons

For wider distribution, consider submitting to the official Community Add-ons repository:

1. Fork [hassio-addons/repository](https://github.com/hassio-addons/repository)
2. Add your add-on
3. Follow their contribution guidelines
4. Submit a pull request

**Requirements:**
- High-quality documentation
- Comprehensive testing
- Active maintenance commitment
- Adherence to their standards

This is optional but gives your add-on more visibility and trust.

## Troubleshooting Publication Issues

### Add-on Not Appearing

- Verify `config.yaml` syntax is correct
- Check `repository.json` has correct URL
- Ensure repository is public
- Clear Home Assistant cache and refresh

### Users Can't Install

- Check GitHub repository permissions
- Verify all required files are present
- Test installation yourself
- Check Home Assistant logs

### Docker Image Issues

- Ensure base image is accessible
- Verify `build.yaml` architecture settings
- Check Docker Hub for image availability

## Example Repositories

Learn from these excellent add-on repositories:

- [Official Home Assistant Add-ons](https://github.com/home-assistant/addons)
- [Community Add-ons](https://github.com/hassio-addons/repository)
- [ESPHome Add-on](https://github.com/esphome/home-assistant-addon)

## Support and Questions

If you need help publishing:

- [Home Assistant Forums - Add-on Development](https://community.home-assistant.io/c/third-party-addons)
- [Home Assistant Discord](https://discord.gg/home-assistant)
- [Add-on Documentation](https://developers.home-assistant.io/docs/add-ons)

## Congratulations!

You've successfully published your Manyfold add-on! Users can now easily install Manyfold in their Home Assistant instances thanks to your work. 🎉

Remember to:
- ✅ Keep the add-on updated
- ✅ Respond to issues
- ✅ Improve documentation
- ✅ Share with the community

Thank you for contributing to the Home Assistant ecosystem!
