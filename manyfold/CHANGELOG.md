# Changelog

All notable changes to this add-on will be documented in this file.

## [1.0.0] - 2025-01-06

### Added
- Initial release of Manyfold Home Assistant Add-on
- Support for SQLite, PostgreSQL, and MySQL databases
- Configurable user/group IDs (PUID/PGID)
- Multi-architecture support (amd64, aarch64, armv7, armhf)
- Automatic secret key generation
- Integration with Home Assistant storage paths (/share, /media, /config)
- Multiuser mode support
- Usage tracking configuration option
- Comprehensive documentation

### Features
- Based on Manyfold Solo image for simplified deployment
- Web interface on port 3214
- Full 3D model viewer
- Model organization with tags, collections, and creators
- Support for STL, OBJ, 3MF, and many other 3D formats
- ActivityPub federation support
- File upload and automatic scanning
- Search and filtering capabilities

### Technical Details
- Uses ghcr.io/manyfold3d/manyfold-solo:latest base image
- Integrated Redis for background job processing
- Persistent data storage in /data
- Configurable database backends
- Supervisor integration for proper Home Assistant lifecycle management

## Future Roadmap

### Planned for 1.1.0
- [ ] Ingress support for seamless Home Assistant UI integration
- [ ] OAuth authentication with Home Assistant users
- [ ] Backup/restore automation
- [ ] Enhanced configuration options
- [ ] Home Assistant sensor for library statistics

### Planned for 1.2.0
- [ ] MQTT integration for model updates
- [ ] Integration with 3D printer add-ons (OctoPrint, etc.)
- [ ] Automated model organization rules
- [ ] Notification support for new uploads

### Planned for 2.0.0
- [ ] Switch to standard Manyfold image with external Redis
- [ ] Advanced federation features
- [ ] Multi-library management UI
- [ ] Performance optimizations for large collections

## Version History

See [Manyfold releases](https://github.com/manyfold3d/manyfold/releases) for upstream changes.
