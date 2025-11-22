# Kubernetes SRE Agent - Usage Examples

This document provides real-world examples of using the k8s-sre agent to troubleshoot and debug Kubernetes clusters.

## Table of Contents

1. [Pod Troubleshooting](#pod-troubleshooting)
2. [Log Analysis](#log-analysis)
3. [Resource Management](#resource-management)
4. [Networking Issues](#networking-issues)
5. [Performance Investigation](#performance-investigation)
6. [Security Audits](#security-audits)
7. [Incident Response](#incident-response)
8. [Routine Maintenance](#routine-maintenance)

---

## Pod Troubleshooting

### Example 1: CrashLoopBackOff

**Scenario**: Your pod keeps restarting

```bash
opencode --agent k8s-sre -p "Pod 'api-server-7d9f8b' in namespace 'production' is in CrashLoopBackOff"
```

**What the agent does**:
1. Gets pod details and status
2. Retrieves current and previous container logs
3. Checks recent events
4. Analyzes exit codes
5. Identifies the root cause (e.g., missing env var, failing health check)
6. Provides fix recommendations

**Example conversation**:
```
Agent: I'll help debug the CrashLoopBackOff issue. First, let me get the pod details...

Agent: I found the issue:
- Exit Code: 1
- Last log entry: "Error: MYSQL_HOST environment variable not set"
- The pod is missing required environment variables

Recommendations:
1. Add MYSQL_HOST to your deployment's env section
2. Or create a ConfigMap with the required variables
3. Check if the ConfigMap reference exists and is spelled correctly
```

### Example 2: ImagePullBackOff

**Scenario**: Pods can't pull container images

```bash
opencode --agent k8s-sre -p "Deployment 'web-app' pods showing ImagePullBackOff in staging namespace"
```

**What the agent does**:
1. Describes the pod to see the exact error
2. Checks events for authentication or network issues
3. Verifies image name and tag
4. Checks if image pull secrets exist
5. Suggests corrections

### Example 3: OOMKilled

**Scenario**: Pod is being killed due to memory limits

```bash
opencode --agent k8s-sre -p "Pod 'worker-3' keeps getting OOMKilled"
```

**What the agent does**:
1. Checks the pod's memory limits and requests
2. Reviews last container exit reason
3. Analyzes memory usage patterns if metrics available
4. Suggests appropriate memory limits
5. Recommends memory profiling if needed

---

## Log Analysis

### Example 4: Finding Errors in Logs

**Scenario**: Application errors in production

```bash
opencode --agent k8s-sre -p "Find all error messages in 'payment-service' logs from the last 2 hours in production namespace"
```

**What the agent does**:
1. Retrieves logs with time filter
2. Searches for error patterns (ERROR, FATAL, Exception, etc.)
3. Groups similar errors
4. Provides error summary and frequency
5. Suggests investigation paths

### Example 5: Comparing Logs Across Replicas

**Scenario**: One replica behaving differently

```bash
opencode --agent k8s-sre -p "Compare logs between all replicas of 'api-deployment' and find differences"
```

**What the agent does**:
1. Lists all pods for the deployment
2. Retrieves logs from each replica
3. Compares log patterns and error rates
4. Identifies anomalies in specific replicas
5. Suggests why one might behave differently

### Example 6: Tracing a Request

**Scenario**: Debug a specific user request

```bash
opencode --agent k8s-sre -p "Find all log entries related to request ID 'req-12345' across all pods in 'microservices' namespace"
```

---

## Resource Management

### Example 7: Resource Usage Overview

**Scenario**: Check overall cluster resource usage

```bash
opencode --agent k8s-sre -p "Show me the top 10 pods by memory usage and their resource limits"
```

**What the agent does**:
1. Runs `kubectl top pods` across namespaces
2. Compares usage to limits and requests
3. Identifies over-provisioned or under-provisioned pods
4. Suggests optimizations

### Example 8: Node Resource Investigation

**Scenario**: Node running out of resources

```bash
opencode --agent k8s-sre -p "Node 'worker-node-3' is showing high memory usage, investigate what's consuming resources"
```

**What the agent does**:
1. Gets node details and status
2. Lists all pods on the node
3. Checks pod resource usage
4. Identifies resource-heavy pods
5. Suggests rebalancing or scaling

### Example 9: Pending Pods

**Scenario**: Pods stuck in Pending state

```bash
opencode --agent k8s-sre -p "Why are pods in 'ml-training' namespace stuck in Pending state?"
```

**What the agent does**:
1. Gets pending pod details
2. Checks events for scheduling failures
3. Reviews resource requests vs. node capacity
4. Checks for taints/tolerations
5. Identifies the blocker (insufficient CPU, GPU, storage, etc.)

---

## Networking Issues

### Example 10: Service Connectivity

**Scenario**: Pods can't reach a service

```bash
opencode --agent k8s-sre -p "Pod 'frontend-abc123' cannot connect to service 'backend-api' in namespace 'prod'"
```

**What the agent does**:
1. Verifies service exists and has endpoints
2. Checks if backend pods are ready
3. Tests DNS resolution (if possible)
4. Reviews network policies
5. Suggests network debugging steps

### Example 11: DNS Issues

**Scenario**: DNS resolution failing

```bash
opencode --agent k8s-sre -p "Pods are experiencing DNS resolution failures in 'app' namespace"
```

**What the agent does**:
1. Checks CoreDNS pods status
2. Reviews DNS configuration
3. Tests DNS from a pod (with permission)
4. Checks network policies affecting DNS
5. Suggests DNS troubleshooting steps

### Example 12: External Connectivity

**Scenario**: Pods can't reach external services

```bash
opencode --agent k8s-sre -p "Pods cannot reach external API at api.example.com"
```

---

## Performance Investigation

### Example 13: Slow Response Times

**Scenario**: Application performance degradation

```bash
opencode --agent k8s-sre -p "API response times have increased significantly in the last hour"
```

**What the agent does**:
1. Checks pod resource usage and throttling
2. Reviews recent changes (rollouts, scaling events)
3. Analyzes logs for slow queries or timeouts
4. Checks for resource contention
5. Suggests performance investigation steps

### Example 14: High CPU Usage

**Scenario**: Pods consuming too much CPU

```bash
opencode --agent k8s-sre -p "Pods in 'data-processing' namespace are at 90% CPU, investigate the cause"
```

**What the agent does**:
1. Identifies which containers are CPU-heavy
2. Checks if this is expected (e.g., batch jobs)
3. Reviews CPU limits and requests
4. Suggests CPU profiling or optimization
5. Recommends horizontal pod autoscaling if appropriate

### Example 15: Disk Pressure

**Scenario**: Nodes experiencing disk pressure

```bash
opencode --agent k8s-sre -p "Nodes are showing disk pressure warnings"
```

---

## Security Audits

### Example 16: Privileged Containers

**Scenario**: Identify security risks

```bash
opencode --agent k8s-sre -p "List all pods running in privileged mode across all namespaces"
```

**What the agent does**:
1. Searches all namespaces for privileged pods
2. Lists security contexts
3. Highlights security risks
4. Suggests least-privilege alternatives

### Example 17: Root Containers

**Scenario**: Find containers running as root

```bash
opencode --agent k8s-sre -p "Find all containers running as root user in 'production' namespace"
```

### Example 18: Exposed Secrets

**Scenario**: Check for hardcoded secrets

```bash
opencode --agent k8s-sre -p "Check environment variables for potential exposed secrets in 'web' namespace"
```

---

## Incident Response

### Example 19: Service Outage

**Scenario**: Critical service is down

```bash
opencode --agent k8s-sre -p "URGENT: payment-service in production is completely down, all pods are failing"
```

**What the agent does**:
1. Quickly assesses pod status
2. Retrieves recent logs and events
3. Identifies immediate cause
4. Provides emergency remediation steps
5. Suggests rollback if needed

### Example 20: Deployment Failure

**Scenario**: New deployment causing issues

```bash
opencode --agent k8s-sre -p "Just deployed v2.5.0 and now 50% of requests are failing"
```

**What the agent does**:
1. Compares old vs new pod versions
2. Checks rollout status
3. Reviews error rates in logs
4. Identifies breaking changes
5. Suggests immediate rollback or forward fix

### Example 21: Resource Exhaustion

**Scenario**: Cluster resources maxed out

```bash
opencode --agent k8s-sre -p "Cluster is out of capacity, many pods are pending"
```

---

## Routine Maintenance

### Example 22: Health Check

**Scenario**: Daily cluster health check

```bash
opencode --agent k8s-sre -p "Give me a health report of the cluster"
```

**What the agent does**:
1. Checks node status
2. Lists failed/pending pods
3. Reviews critical events
4. Checks system namespace health
5. Provides summary report

### Example 23: Find Old Resources

**Scenario**: Clean up stale resources

```bash
opencode --agent k8s-sre -p "Find all pods that have been running for more than 30 days"
```

### Example 24: Version Audit

**Scenario**: Check component versions

```bash
opencode --agent k8s-sre -p "Show me Kubernetes version and all component versions"
```

---

## Advanced Use Cases

### Example 25: Multi-Namespace Investigation

**Scenario**: Cross-namespace issue

```bash
opencode --agent k8s-sre -p "Service mesh issues affecting multiple namespaces, investigate traffic flow from 'frontend' to 'backend' namespace"
```

### Example 26: StatefulSet Issues

**Scenario**: StatefulSet pod problems

```bash
opencode --agent k8s-sre -p "StatefulSet 'cassandra' in 'database' namespace - pod cassandra-2 won't start"
```

**What the agent does**:
1. Checks StatefulSet status and events
2. Reviews PVC status and bindings
3. Checks pod ordering requirements
4. Analyzes volume attachment issues
5. Suggests StatefulSet-specific fixes

### Example 27: Custom Resource Debugging

**Scenario**: CRD-based resources failing

```bash
opencode --agent k8s-sre -p "My Istio VirtualService 'api-route' is not working, investigate why traffic isn't routing correctly"
```

### Example 28: Job Failures

**Scenario**: Kubernetes Job not completing

```bash
opencode --agent k8s-sre -p "CronJob 'backup-job' failed last 3 runs, find out why"
```

**What the agent does**:
1. Gets Job status and history
2. Reviews failed pod logs
3. Checks job configuration
4. Analyzes retry logic
5. Suggests fixes for reliability

---

## Interactive Troubleshooting Sessions

### Example 29: Guided Debugging

**Launch**: `opencode --agent k8s-sre`

**Conversation flow**:
```
You: I have a problem with my application
Agent: I'll help you debug. Which Kubernetes context should I use?
You: production-cluster
Agent: Got it. What issue are you experiencing?
You: Users are reporting slow page loads
Agent: Let me investigate. Which namespace is the application in?
You: web-frontend
Agent: I'll check the pod status and resource usage...
[Agent performs investigation and provides step-by-step guidance]
```

### Example 30: Root Cause Analysis

**Launch**: `opencode --agent k8s-sre -p "Walk me through debugging a memory leak in 'api-service'"`

**The agent will**:
1. Ask clarifying questions
2. Gather evidence systematically
3. Form hypotheses
4. Test each hypothesis
5. Guide you to the root cause
6. Suggest remediation and prevention

---

## Tips for Effective Usage

1. **Be Specific**: Include namespace, pod names, and symptoms
2. **Provide Context**: Mention recent changes or when issues started
3. **Use Time Ranges**: Specify time windows for log analysis
4. **Ask Follow-ups**: The agent can dig deeper based on initial findings
5. **Grant Permissions**: Approve exec commands for deeper investigation when safe
6. **Learn Patterns**: Ask the agent to explain what it's doing and why

## Common Patterns

| Issue Type | Example Command |
|------------|----------------|
| Pod won't start | `"Debug pod X that won't start in namespace Y"` |
| High resource usage | `"Investigate high CPU/memory in namespace X"` |
| Connectivity issues | `"Pod A cannot reach service B"` |
| Log analysis | `"Find errors in X from last N hours"` |
| Performance | `"Application is slow, investigate"` |
| After deployment | `"Just deployed version X, now seeing errors"` |
| Health check | `"Give me cluster health report"` |

---

## Next Steps

After resolving issues with the agent:
1. Document the root cause and fix
2. Update runbooks with new insights
3. Consider preventive measures
4. Add monitoring/alerting for similar issues
5. Share knowledge with your team

**Remember**: The agent is a tool to assist you, not replace your expertise. Always review its suggestions and approve commands thoughtfully.
