# Changelog

All notable changes to the Kubernetes SRE Agent will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-11-22

### Added
- Initial release of the Kubernetes SRE Agent for OpenCode
- Primary agent configuration with Claude Sonnet 4
- Comprehensive system prompt with SRE expertise
- Safety controls preventing destructive operations
- Permission-based access for `kubectl exec` and port-forwarding
- Automatic blocking of delete, apply, edit, patch, scale operations
- Context selection workflow for multi-cluster environments
- Full documentation suite:
  - README.md with installation and usage guide
  - EXAMPLES.md with 30+ real-world scenarios
  - QUICKSTART.md for fast onboarding
  - This CHANGELOG
- Installation script with interactive setup
- Uninstallation script for clean removal
- Support for both global and project-specific installation
- Temperature set to 0.3 for balanced responses
- Enabled tools: Bash, Read, Glob, Grep
- Disabled tools: Write, Edit (for safety)

### Security
- Implemented deny rules for all destructive kubectl operations
- Added ask rules for potentially impactful operations (exec, port-forward)
- Restricted write access to prevent accidental file modifications
- Built-in context verification reminders

### Documentation
- Complete installation guide with prerequisites
- 30+ usage examples covering common scenarios
- Troubleshooting section for common issues
- Configuration customization guide
- Uninstallation instructions
- License (MIT)

## [Unreleased]

### Planned
- Integration examples with monitoring tools
- Templates for common troubleshooting workflows
- Support for specific Kubernetes distributions (EKS, GKE, AKS)
- Custom tool definitions for advanced diagnostics
- Multi-language support in prompts
- Integration with runbook systems
- Metrics and alerting integration examples

## Version History

| Version | Date | Description |
|---------|------|-------------|
| 1.0.0 | 2025-11-22 | Initial release |

## Contributing

See individual version sections above for details on what changed. To contribute to future versions, see the README for contribution guidelines.

## Notes

- This is the initial release version
- Tested with OpenCode and kubectl on Linux, macOS, and WSL2
- Compatible with Kubernetes 1.20+
- Works with all major cloud providers (AWS EKS, Google GKE, Azure AKS, etc.)
