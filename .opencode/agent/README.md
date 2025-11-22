# Kubernetes SRE Agent

This directory contains the **k8s-sre** agent - an AI Site Reliability Engineer specialized in Kubernetes troubleshooting and debugging.

## Quick Start

### Launch the agent
```bash
opencode --agent k8s-sre
```

### Or start with a specific task
```bash
opencode --agent k8s-sre -p "Debug pod crashes in production namespace"
```

### List all available agents
```bash
opencode agent list
```

## Agent Capabilities

The k8s-sre agent can help you with:

- **View Resources**: Get and describe any Kubernetes resources (pods, deployments, services, CRDs, etc.)
- **Analyze Logs**: Retrieve and analyze container logs, including previous container logs
- **Port Forwarding**: Set up port forwarding to access services locally (with permission)
- **Execute Commands**: Run diagnostic commands inside pods (with permission)
- **Troubleshooting**: Guide you through debugging steps and identify issues
- **Best Practices**: Recommend Kubernetes improvements

## Safety Features

The agent has built-in safety restrictions:

1. **Cannot Delete**: All `kubectl delete` commands are blocked
2. **Cannot Modify**: Commands like `apply`, `edit`, `patch`, `replace`, `scale` are blocked
3. **Requires Permission**: `kubectl exec` and port-forwarding require your explicit approval
4. **Context Verification**: Always asks which cluster/context to use

## Example Usage

### Troubleshoot a failing pod
```bash
opencode --agent k8s-sre
# Then tell it: "My pod 'api-server' in namespace 'production' keeps crashing"
```

### Analyze application logs
```bash
opencode --agent k8s-sre -p "Analyze logs for errors in namespace 'staging'"
```

### Check cluster health
```bash
opencode --agent k8s-sre -p "Check the overall health of my cluster"
```

## Configuration

The agent configuration is stored in `.opencode/agent/k8s-sre.md`

You can customize:
- System prompt and instructions
- Model settings (currently using Claude Sonnet 4)
- Temperature (currently 0.3 for balanced creativity)
- Tool access and permissions

## Permissions

The agent uses the following permission model:
- **Allow**: All read-only kubectl commands (get, describe, logs, etc.)
- **Ask**: Commands that execute in pods or set up port forwarding
- **Deny**: Any destructive or modifying operations

To modify permissions, edit the `permission` section in `.opencode/agent/k8s-sre.md`

## Tips

1. Always specify the namespace when working with resources
2. The agent will ask which context to use - make sure you select the right cluster
3. Use the agent for investigation and diagnosis, not for making changes
4. When debugging, provide context about what you're experiencing
5. The agent can read logs, events, and resource descriptions to help diagnose issues

## Technical Details

- **Model**: Claude Sonnet 4 (anthropic/claude-sonnet-4-20250514)
- **Mode**: Primary agent
- **Temperature**: 0.3
- **Tools**: Bash, Read, Glob, Grep (Write and Edit disabled)
