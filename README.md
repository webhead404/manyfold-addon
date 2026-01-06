# Home Assistant Add-ons Repository

This repository contains Home Assistant add-ons.

## Add-ons

This repository contains the following add-ons:

### [Manyfold](./manyfold/)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]

_Self-hosted digital asset manager for 3D print files._

A self-hosted digital asset manager for 3D print files. View and organize your collection of 3D models in full interactive 3D, sort by tags, creators, and collections.

**Features:**
- 📦 Interactive 3D model viewer
- 🏷️ Smart organization with tags and collections  
- 🔍 Full-text search across your library
- 📤 Easy upload via web interface
- 🌐 ActivityPub federation support
- 🔐 Privacy-first (all data stays on your server)
- 📱 Mobile-friendly responsive interface

## Installation

To use these add-ons, add this repository to your Home Assistant instance:

[![Add Repository to Home Assistant][repository-badge]][repository-url]

Or manually:

1. Navigate to **Settings** → **Add-ons** → **Add-on Store**
2. Click the **⋮** menu (three dots) in the top right
3. Select **Repositories**
4. Add this URL:
   ```
   https://github.com/YOUR_USERNAME/hassio-addons
   ```
5. Click **Add**
6. Find **Manyfold** in the add-on store and click **Install**

## Support

For issues, questions, or contributions:

- [Open an issue on GitHub](https://github.com/YOUR_USERNAME/hassio-addons/issues)
- [Manyfold Documentation](https://manyfold.app)
- [Home Assistant Community](https://community.home-assistant.io)

## Credits

- [Manyfold](https://github.com/manyfold3d/manyfold) by @Floppy and contributors
- Add-on packaging by [Your Name]

## License

MIT License - See individual add-ons for specific licensing details.

---

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[repository-badge]: https://img.shields.io/badge/Add%20repository-41BDF5?logo=home-assistant&logoColor=white
[repository-url]: https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FYOUR_USERNAME%2Fhassio-addons
