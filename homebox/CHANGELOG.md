# Changelog

## [1.0.0] - 2026-01-07

### Added
- Initial release of Homebox Home Assistant add-on
- Based on official Homebox image (sysadminsmedia fork)
- Configuration options for log level, upload size, and registration
- Data persistence via /data mount
- Multi-architecture support (amd64, aarch64, armv7, armhf)
- Comprehensive documentation

### Features
- Home inventory management
- QR code generation for items
- Multi-user support with groups
- Photo and document attachments
- Location and label organization
- Warranty tracking
- Search functionality
- SQLite database (no external database needed)

### Configuration
- `log_level`: Control logging verbosity
- `max_upload_size`: Set maximum upload size for attachments
- `allow_registration`: Enable/disable user registration

### Notes
- Uses port 7745 (Homebox default)
- Data stored in `/data/` for persistence
- Regular (non-rootless) image used for simplicity
