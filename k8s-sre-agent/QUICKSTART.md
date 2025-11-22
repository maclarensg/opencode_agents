# Quick Start Guide

Get up and running with the Kubernetes SRE Agent in 5 minutes!

## Prerequisites

- ✅ OpenCode installed ([Get OpenCode](https://opencode.ai))
- ✅ kubectl installed and configured
- ✅ Access to a Kubernetes cluster

## Installation (30 seconds)

```bash
# Clone or download this repository
git clone <repository-url>  # or download and extract

# Navigate to the directory
cd k8s-sre-agent

# Run the installer
./install.sh
```

Follow the prompts:
- Choose **1** for global installation (available everywhere)
- Or **2** for project-specific installation

## First Use (2 minutes)

### 1. Verify Installation

```bash
opencode agent list
```

You should see `k8s-sre (primary)` in the list.

### 2. Launch the Agent

```bash
opencode --agent k8s-sre
```

The agent will:
1. Ask which Kubernetes context to use
2. Wait for your task or question

### 3. Try a Simple Task

When the agent starts, type:

```
Show me all pods in the default namespace
```

The agent will run `kubectl get pods` and explain what it sees.

## Common First Tasks

### Debug a Crashing Pod
```bash
opencode --agent k8s-sre -p "My pod 'api-server' keeps crashing in production namespace"
```

### Check Cluster Health
```bash
opencode --agent k8s-sre -p "Give me a health overview of the cluster"
```

### Analyze Logs for Errors
```bash
opencode --agent k8s-sre -p "Find errors in 'web-app' logs from the last hour"
```

### Investigate High Resource Usage
```bash
opencode --agent k8s-sre -p "Which pods are using the most memory?"
```

## What Can I Ask?

The agent understands natural language. Try asking:

- "Why is my pod not starting?"
- "Show me what's wrong with the cluster"
- "Find all failed pods"
- "Help me debug service connectivity issues"
- "What's consuming CPU in namespace X?"
- "Show me recent errors in the logs"

## Safety Features

Don't worry - the agent **cannot**:
- ❌ Delete resources
- ❌ Modify configurations
- ❌ Apply changes
- ❌ Scale deployments

It **will ask permission** before:
- ⚠️ Running commands in pods (`kubectl exec`)
- ⚠️ Setting up port forwarding

## Next Steps

1. **Read Full Docs**: Check out [README.md](README.md) for comprehensive documentation
2. **See Examples**: Browse [EXAMPLES.md](EXAMPLES.md) for 30+ real-world scenarios
3. **Customize**: Edit `k8s-sre.md` to add your own instructions or constraints
4. **Share**: Give this agent to your team!

## Getting Help

### Agent Not Listed?
```bash
# Check if file exists
ls -la ~/.config/opencode/agent/k8s-sre.md
# or
ls -la .opencode/agent/k8s-sre.md
```

### kubectl Not Working?
```bash
# Verify kubectl is installed
kubectl version --client

# Check your contexts
kubectl config get-contexts
```

### Need to Uninstall?
```bash
./uninstall.sh
```

## Tips for Success

1. **Be Specific**: Include namespace names and pod names
2. **Provide Context**: Mention what changed or when issues started
3. **Ask Follow-ups**: The agent remembers the conversation
4. **Use the Right Context**: Always verify which cluster you're working with
5. **Grant Permissions Thoughtfully**: Review exec commands before approving

## Example Session

```bash
$ opencode --agent k8s-sre

Agent: I'm your Kubernetes SRE assistant. Which context should I use?

You: production-cluster

Agent: Connected to production-cluster. What can I help you with?

You: My users are reporting slow response times

Agent: Let me investigate. Which namespace is the application in?

You: web-frontend

Agent: I'll check the pod status and resource usage...
[Agent investigates and provides findings]

Agent: I found the issue:
- 3 out of 5 pods are at 95% CPU
- The pods are hitting their CPU limits and being throttled
- This started about 2 hours ago

Would you like me to:
1. Show you the top CPU-consuming pods
2. Check if there's a recent deployment that might have caused this
3. Review the pod logs for errors

You: Option 2

[Agent continues investigation...]
```

## That's It!

You're ready to use the Kubernetes SRE Agent. Happy debugging! 🚀

For more detailed information, see:
- [README.md](README.md) - Full documentation
- [EXAMPLES.md](EXAMPLES.md) - 30+ usage examples
- [k8s-sre.md](k8s-sre.md) - Agent configuration (for customization)
