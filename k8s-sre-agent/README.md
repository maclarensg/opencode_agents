# Kubernetes SRE Agent for OpenCode

An AI Site Reliability Engineer agent for OpenCode that helps you troubleshoot and debug Kubernetes clusters safely and efficiently.

## Overview

This agent is designed to assist with Kubernetes operations while maintaining strict safety controls:
- ✅ View and analyze any Kubernetes resources
- ✅ Retrieve and analyze container logs
- ✅ Execute diagnostic commands (with permission)
- ✅ Set up port forwarding (with permission)
- ❌ **Cannot** delete, modify, or scale resources
- ❌ **Cannot** apply configurations or make cluster changes

## Prerequisites

- [OpenCode](https://opencode.ai) installed on your machine
- `kubectl` installed and configured
- Access to at least one Kubernetes cluster

## Quick Installation

### Method 1: Automatic Installation (Recommended)

```bash
# Clone or download this repository
cd k8s-sre-agent

# Run the installation script
./install.sh
```

The script will:
1. Detect if you want global or project-specific installation
2. Copy the agent configuration to the correct location
3. Verify the installation

### Method 2: Manual Installation

#### For Project-Specific Installation

1. Navigate to your project directory:
   ```bash
   cd /path/to/your/project
   ```

2. Create the agent directory:
   ```bash
   mkdir -p .opencode/agent
   ```

3. Copy the agent configuration:
   ```bash
   cp /path/to/k8s-sre-agent/k8s-sre.md .opencode/agent/
   ```

4. Verify installation:
   ```bash
   opencode agent list
   ```
   You should see `k8s-sre (primary)` in the output.

#### For Global Installation

1. Create the global agent directory:
   ```bash
   mkdir -p ~/.config/opencode/agent
   ```

2. Copy the agent configuration:
   ```bash
   cp /path/to/k8s-sre-agent/k8s-sre.md ~/.config/opencode/agent/
   ```

3. Verify installation:
   ```bash
   opencode agent list
   ```

## Usage

### Launch the Agent

```bash
opencode --agent k8s-sre
```

### Quick Start Examples

#### Example 1: Troubleshoot a Crashing Pod
```bash
opencode --agent k8s-sre -p "My pod 'api-server' in namespace 'production' keeps crashing"
```

The agent will:
1. Ask which Kubernetes context to use
2. Get the pod status and details
3. Retrieve recent logs
4. Check for recent events
5. Analyze the issue and provide recommendations

#### Example 2: Analyze Application Logs
```bash
opencode --agent k8s-sre -p "Find all errors in the 'web-app' logs from the last hour in namespace 'staging'"
```

#### Example 3: Check Cluster Health
```bash
opencode --agent k8s-sre -p "Give me an overview of the cluster health"
```

The agent will check:
- Node status and resources
- Failed or pending pods
- Recent critical events
- Resource usage

#### Example 4: Debug Networking Issues
```bash
opencode --agent k8s-sre -p "Pod 'frontend' cannot connect to service 'backend' in namespace 'prod'"
```

## Agent Capabilities

### What the Agent Can Do

1. **View Resources**
   - Get and describe pods, deployments, services, configmaps, secrets
   - View custom resources (CRDs)
   - Check node status and resource usage
   - View events and resource quotas

2. **Analyze Logs**
   - Retrieve current and previous container logs
   - Filter logs by time range
   - Search for errors and patterns
   - Compare logs across multiple pods

3. **Diagnostics** (with permission)
   - Execute commands inside containers
   - Set up port forwarding to services
   - Run health checks and connectivity tests

4. **Troubleshooting**
   - Identify common issues (OOMKilled, ImagePullBackOff, CrashLoopBackOff, etc.)
   - Analyze resource constraints
   - Check service endpoints and networking
   - Review recent changes and events

### Safety Features

The agent has built-in safety controls:

| Operation | Permission |
|-----------|------------|
| `kubectl get`, `describe`, `logs` | ✅ Allowed automatically |
| `kubectl exec` | ⚠️ Requires user approval each time |
| `kubectl port-forward` | ⚠️ Requires user approval each time |
| `kubectl delete`, `apply`, `edit`, `patch`, `scale` | ❌ Blocked completely |

## Configuration

The agent configuration is stored in `k8s-sre.md`. You can customize:

### Change the Model
```yaml
model: anthropic/claude-sonnet-4-20250514  # or use other models
```

### Adjust Temperature
```yaml
temperature: 0.3  # 0.0 = deterministic, 1.0 = creative
```

### Modify Permissions
```yaml
permission:
  Bash(kubectl exec*): ask      # ask, allow, or deny
  Bash(kubectl delete*): deny   # prevent destructive operations
```

### Available Tools
```yaml
tools:
  bash: true   # Run shell commands
  read: true   # Read files
  write: false # Disabled for safety
  edit: false  # Disabled for safety
  glob: true   # Find files
  grep: true   # Search files
```

## Common Workflows

### Workflow 1: Pod Troubleshooting
1. Launch agent: `opencode --agent k8s-sre`
2. Select Kubernetes context
3. Describe the issue: "Pod X is failing in namespace Y"
4. Agent will:
   - Get pod status and details
   - Retrieve logs from current and previous containers
   - Check events for the pod
   - Analyze resource limits and requests
   - Provide recommendations

### Workflow 2: Performance Investigation
1. Launch: `opencode --agent k8s-sre -p "High memory usage in production"`
2. Agent will:
   - Check node resources
   - List top resource consumers
   - Analyze pod resource usage
   - Suggest optimizations

### Workflow 3: Log Analysis
1. Launch: `opencode --agent k8s-sre`
2. Request: "Analyze application logs for the last 30 minutes"
3. Agent will:
   - Retrieve logs with appropriate time filters
   - Search for errors and warnings
   - Identify patterns or anomalies
   - Summarize findings

## Tips for Best Results

1. **Be Specific**: Include namespace, pod name, and what you're seeing
   - Good: "Pod 'api-v2-7d4f8' in 'production' namespace shows status 'CrashLoopBackOff'"
   - Less good: "My pod is broken"

2. **Provide Context**: Mention recent changes or when the issue started
   - "After deploying version 2.3.1, the pods started restarting"

3. **Use the Right Context**: Always verify you're working with the correct cluster
   - The agent will ask which context to use at the start

4. **Grant Permissions Thoughtfully**: The agent will ask before running exec or port-forward
   - Review the command before approving
   - Deny if you're unsure

5. **Leverage the Agent's Knowledge**: Ask for explanations and best practices
   - "Why is this pod getting OOMKilled?"
   - "What are best practices for resource limits?"

## Troubleshooting

### Agent Not Listed
```bash
# Check if the file exists
ls -la ~/.config/opencode/agent/k8s-sre.md
# or for project-specific
ls -la .opencode/agent/k8s-sre.md

# Verify with list command
opencode agent list
```

### kubectl Not Found
Ensure kubectl is installed and in your PATH:
```bash
which kubectl
kubectl version --client
```

### Permission Denied
The agent configuration includes permission rules. If commands are being denied:
1. Check the `permission:` section in `k8s-sre.md`
2. Verify you're not trying to run destructive operations (these are intentionally blocked)

### Wrong Kubernetes Context
Always verify the context before starting:
```bash
kubectl config current-context
kubectl config get-contexts
```

The agent will ask which context to use, but you can switch manually:
```bash
kubectl config use-context <context-name>
```

## Uninstallation

### Remove Global Installation
```bash
rm ~/.config/opencode/agent/k8s-sre.md
```

### Remove Project Installation
```bash
rm .opencode/agent/k8s-sre.md
```

## Advanced Usage

### Use with Specific Model
You can override the model when launching:
```bash
opencode --agent k8s-sre -m anthropic/claude-opus-4-20250514
```

### Combine with Other OpenCode Features
The agent works with all OpenCode features:
- Use with MCP servers
- Combine with custom tools
- Integrate with your existing workflows

### Customize for Your Environment
Edit `k8s-sre.md` to add:
- Environment-specific instructions
- Custom troubleshooting steps
- Links to your runbooks
- Team conventions and practices

## Examples by Use Case

### Security Audit
```bash
opencode --agent k8s-sre -p "List all pods running as root in namespace 'production'"
```

### Resource Optimization
```bash
opencode --agent k8s-sre -p "Show me pods with the highest memory usage and suggest optimizations"
```

### Incident Response
```bash
opencode --agent k8s-sre -p "Emergency: service 'payment-api' is down in production"
```

### Routine Maintenance
```bash
opencode --agent k8s-sre -p "Check for any pods in CrashLoopBackOff or ImagePullBackOff state"
```

## Contributing

Improvements and suggestions are welcome! Common enhancements:
- Add more example workflows
- Improve troubleshooting guides
- Add support for specific Kubernetes distributions
- Create templates for common tasks

## License

This agent configuration is provided as-is for use with OpenCode. Modify and distribute freely.

## Resources

- [OpenCode Documentation](https://opencode.ai/docs/)
- [OpenCode Agents Guide](https://opencode.ai/docs/agents/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

## Support

For issues with:
- **This agent**: Check the Troubleshooting section above
- **OpenCode**: Visit [OpenCode Documentation](https://opencode.ai/docs/)
- **kubectl**: Refer to [Kubernetes Documentation](https://kubernetes.io/docs/reference/kubectl/)

---

**Happy Debugging!** 🚀
