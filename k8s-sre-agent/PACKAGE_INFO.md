# Kubernetes SRE Agent Package

**Version**: 1.0.0
**Release Date**: November 22, 2025
**License**: MIT

## Package Contents

This package contains everything needed to install and use the Kubernetes SRE Agent for OpenCode.

### Core Files

| File | Description |
|------|-------------|
| `k8s-sre.md` | **Agent configuration** - The main agent definition with AI instructions and permissions |
| `install.sh` | **Installation script** - Automated installer for global or project-specific setup |
| `uninstall.sh` | **Uninstallation script** - Clean removal of the agent |

### Documentation

| File | Purpose | Recommended For |
|------|---------|----------------|
| `README.md` | Complete documentation and reference | Everyone - start here |
| `QUICKSTART.md` | Get started in 5 minutes | New users |
| `EXAMPLES.md` | 30+ real-world usage scenarios | Learning by example |
| `CONTRIBUTING.md` | Contribution guidelines | Contributors |
| `CHANGELOG.md` | Version history and changes | Tracking updates |
| `LICENSE` | MIT license | Legal reference |

### Metadata

| File | Contents |
|------|----------|
| `VERSION` | Current version number (1.0.0) |
| `.gitignore` | Git ignore patterns |
| `PACKAGE_INFO.md` | This file - package overview |

## Quick Reference

### Installation
```bash
cd k8s-sre-agent
./install.sh
```

### Usage
```bash
# Launch the agent
opencode --agent k8s-sre

# Launch with a task
opencode --agent k8s-sre -p "Your task here"

# List agents
opencode agent list
```

### Uninstallation
```bash
./uninstall.sh
```

## What This Agent Does

The Kubernetes SRE Agent is an AI assistant specialized in:

✅ **Viewing & Analyzing**
- Kubernetes resources (pods, deployments, services, CRDs, etc.)
- Container logs and events
- Cluster health and resource usage
- Configuration and status

✅ **Troubleshooting**
- Pod failures (CrashLoopBackOff, ImagePullBackOff, OOMKilled)
- Service connectivity issues
- Resource constraints
- Performance problems
- Log analysis and error detection

✅ **Diagnostics** (with permission)
- Execute commands in pods
- Port forwarding
- Interactive debugging

❌ **Safety Controls**
- Cannot delete resources
- Cannot modify configurations
- Cannot apply changes
- Cannot scale deployments
- All destructive operations blocked

## Technical Specifications

**Model**: Claude Sonnet 4 (anthropic/claude-sonnet-4-20250514)
**Mode**: Primary agent
**Temperature**: 0.3 (balanced)
**Enabled Tools**: Bash, Read, Glob, Grep
**Disabled Tools**: Write, Edit (for safety)

### Permission Model

```yaml
Automatically Allowed:
  - kubectl get/describe/logs (read-only operations)

Requires User Approval:
  - kubectl exec (execute commands in pods)
  - kubectl port-forward (network access)

Completely Blocked:
  - kubectl delete
  - kubectl apply
  - kubectl edit
  - kubectl patch
  - kubectl replace
  - kubectl scale
```

## Installation Locations

**Global Installation**:
- Location: `~/.config/opencode/agent/k8s-sre.md`
- Available: In all OpenCode projects
- Use when: You want the agent everywhere

**Project-Specific Installation**:
- Location: `./.opencode/agent/k8s-sre.md`
- Available: Only in current project directory
- Use when: Testing or project-specific needs

## File Sizes

```
Total package size: ~45 KB (uncompressed)

k8s-sre.md:          4.5 KB  (agent config)
README.md:           9.5 KB  (main docs)
EXAMPLES.md:        12.7 KB  (usage examples)
CONTRIBUTING.md:     7.2 KB  (contribution guide)
install.sh:          5.2 KB  (installer)
uninstall.sh:        4.7 KB  (uninstaller)
QUICKSTART.md:       4.3 KB  (quick start)
CHANGELOG.md:        2.5 KB  (version history)
LICENSE:             1.1 KB  (MIT license)
```

## Distribution

This package can be:
- ✅ Shared freely (MIT licensed)
- ✅ Modified and customized
- ✅ Distributed to teams
- ✅ Committed to version control
- ✅ Packaged for internal use

No attribution required, but appreciated!

## Support

**Prerequisites**:
- OpenCode (https://opencode.ai)
- kubectl configured with cluster access

**Getting Help**:
1. Check README.md for documentation
2. Review EXAMPLES.md for usage patterns
3. See QUICKSTART.md for common issues
4. Refer to CONTRIBUTING.md for modification help

## Version Information

**Current Version**: 1.0.0 (Initial Release)

**Compatibility**:
- OpenCode: Latest version
- Kubernetes: 1.20+
- kubectl: Any recent version
- OS: Linux, macOS, Windows (WSL2)
- Platforms: AWS EKS, Google GKE, Azure AKS, and any Kubernetes

## Customization

The agent can be customized by editing `k8s-sre.md`:

- **Change Model**: Use different Claude models or providers
- **Adjust Temperature**: Control response creativity (0.0-1.0)
- **Modify Permissions**: Add/remove kubectl command restrictions
- **Update Instructions**: Add environment-specific guidance
- **Enable/Disable Tools**: Control which OpenCode tools are available

See CONTRIBUTING.md for customization guidelines.

## Testing

After installation, verify with:

```bash
# 1. Check agent is listed
opencode agent list | grep k8s-sre

# 2. Test basic functionality
opencode --agent k8s-sre -p "Show me all namespaces"

# 3. Verify safety (should refuse)
opencode --agent k8s-sre -p "Delete all pods"

# 4. Test permission prompt (should ask)
opencode --agent k8s-sre -p "Execute 'ls' in pod xyz"
```

## Updates

Check the CHANGELOG.md for version history and updates.

To update to a new version:
1. Download the latest release
2. Run `./uninstall.sh` (optional - to clean old version)
3. Run `./install.sh`

## Security

This agent:
- ✅ Has hardcoded safety restrictions
- ✅ Cannot perform destructive operations
- ✅ Requires permission for impactful commands
- ✅ Works within kubectl's RBAC permissions
- ✅ Includes no executable code (pure configuration)

The agent respects your kubectl RBAC permissions - it cannot do anything your kubectl user cannot do.

## Next Steps

1. **Install**: Run `./install.sh`
2. **Read**: Check QUICKSTART.md for first use
3. **Learn**: Browse EXAMPLES.md for scenarios
4. **Use**: Start troubleshooting with `opencode --agent k8s-sre`
5. **Share**: Give this to your team!

## Questions?

- **How do I use this?** → Start with QUICKSTART.md
- **What can it do?** → See EXAMPLES.md
- **How do I customize it?** → Check CONTRIBUTING.md
- **Is it safe?** → Yes - see Security section above
- **Can I share it?** → Yes - MIT licensed!

---

**Built for**: OpenCode users who work with Kubernetes
**Purpose**: Make Kubernetes troubleshooting faster and easier
**License**: MIT (free to use, modify, and distribute)

Happy debugging! 🚀
