# Contributing to Kubernetes SRE Agent

Thank you for your interest in contributing to the Kubernetes SRE Agent! This document provides guidelines and instructions for contributing.

## Ways to Contribute

There are many ways you can contribute to this project:

1. **Report Bugs**: Found an issue? Let us know!
2. **Suggest Enhancements**: Have ideas for improvements?
3. **Improve Documentation**: Help make the docs clearer
4. **Share Use Cases**: Add examples of how you use the agent
5. **Add Features**: Contribute code improvements
6. **Test**: Try the agent in different environments

## Getting Started

### Prerequisites

- OpenCode installed
- kubectl configured
- Basic understanding of Kubernetes
- Familiarity with Markdown for documentation

### Development Setup

1. Fork or clone the repository
2. Install the agent locally for testing:
   ```bash
   ./install.sh
   ```
3. Make your changes to `k8s-sre.md` or documentation files
4. Test your changes with:
   ```bash
   opencode --agent k8s-sre
   ```

## Making Changes

### Documentation Changes

Documentation improvements are always welcome!

**Files you might edit**:
- `README.md` - Main documentation
- `EXAMPLES.md` - Usage examples
- `QUICKSTART.md` - Getting started guide
- `CONTRIBUTING.md` - This file

**Guidelines**:
- Keep language clear and concise
- Include examples where helpful
- Test any code snippets you add
- Follow existing formatting style

### Agent Configuration Changes

The main agent configuration is in `k8s-sre.md`.

**When editing the agent**:

1. **YAML Frontmatter**: Configuration settings
   ```yaml
   ---
   description: Brief description
   mode: primary
   model: anthropic/claude-sonnet-4-20250514
   temperature: 0.3
   tools:
     bash: true
     # ... other tools
   permission:
     Bash(kubectl delete*): deny
     # ... other permissions
   ---
   ```

2. **System Prompt**: Instructions for the AI
   - Keep safety rules prominent
   - Be clear and specific
   - Use examples where helpful
   - Maintain the structured format

**Testing Changes**:
```bash
# Reinstall after changes
./install.sh

# Test the agent
opencode --agent k8s-sre -p "Test query"

# Verify safety controls
# Try commands that should be blocked
```

### Permission Rules

When modifying permissions, follow these principles:

1. **Safety First**: Deny destructive operations by default
2. **Ask for Impact**: Require user approval for impactful operations
3. **Allow Read**: Read-only operations should be allowed
4. **Document**: Explain why each permission is set

**Example**:
```yaml
permission:
  # Deny destructive operations
  Bash(kubectl delete*): deny
  Bash(kubectl apply*): deny

  # Ask for potentially impactful operations
  Bash(kubectl exec*): ask
  Bash(kubectl port-forward*): ask

  # Allow read-only operations
  Bash(kubectl get*): allow
  Bash(kubectl describe*): allow
  Bash(kubectl logs*): allow
```

## Submitting Changes

### For Small Changes

1. Make your changes
2. Test thoroughly
3. Update relevant documentation
4. Submit your changes (via PR, email, or issue)

### For Larger Changes

1. Open an issue first to discuss the change
2. Get feedback on the approach
3. Implement the changes
4. Test comprehensively
5. Update documentation
6. Submit your changes

## Testing Guidelines

### Manual Testing

Test your changes across different scenarios:

```bash
# Test basic functionality
opencode --agent k8s-sre -p "List all pods"

# Test safety controls
opencode --agent k8s-sre -p "Delete pod xyz"
# Should refuse or require permission

# Test context switching
opencode --agent k8s-sre -p "Switch to different context"

# Test error handling
opencode --agent k8s-sre -p "Get pod that-doesnt-exist"
```

### Test Scenarios

Consider testing:
- ✅ Pod troubleshooting
- ✅ Log analysis
- ✅ Resource investigation
- ✅ Network debugging
- ✅ Permission enforcement
- ✅ Context selection
- ✅ Error handling

## Adding Examples

We love new examples! To add an example to `EXAMPLES.md`:

1. **Choose a real scenario**: Based on actual troubleshooting
2. **Show the command**: What you'd type to launch the agent
3. **Explain the process**: What the agent does
4. **Include output**: Example of what the user sees
5. **Add tips**: How to get the best results

**Example template**:
```markdown
### Example N: Descriptive Title

**Scenario**: Brief description of the problem

\`\`\`bash
opencode --agent k8s-sre -p "Your query here"
\`\`\`

**What the agent does**:
1. First step
2. Second step
3. Analysis
4. Recommendations

**Expected output**:
\`\`\`
[Example of agent response]
\`\`\`

**Tips**:
- Tip 1
- Tip 2
```

## Code Style

### Markdown

- Use ATX-style headers (`#`, `##`, `###`)
- Include blank lines between sections
- Use fenced code blocks with language hints
- Keep lines under 120 characters when possible

### YAML (in k8s-sre.md)

- Use 2-space indentation
- Quote strings when they contain special characters
- Comment complex configurations

### Bash Scripts

- Use `#!/bin/bash` shebang
- Include comments for complex logic
- Use `set -e` for safety
- Quote variables: `"$var"`
- Use descriptive variable names

## Documentation Standards

### Writing Style

- **Be Clear**: Write for users new to the agent
- **Be Concise**: Avoid unnecessary words
- **Be Helpful**: Include examples and tips
- **Be Accurate**: Test all code snippets
- **Be Consistent**: Follow existing patterns

### Code Examples

- Include context (what command does)
- Show expected output when helpful
- Explain why, not just what
- Test all examples before submitting

## Proposing Enhancements

### Before Proposing

1. Check if it's already suggested (in issues/discussions)
2. Consider if it aligns with the agent's purpose
3. Think about backwards compatibility
4. Consider security implications

### Enhancement Template

When suggesting enhancements, include:

1. **Summary**: Brief description
2. **Motivation**: Why is this useful?
3. **Proposal**: How would it work?
4. **Examples**: Show usage examples
5. **Alternatives**: Other approaches considered
6. **Impact**: What changes would be needed?

## Reporting Bugs

### Bug Report Template

```markdown
**Description**
Clear description of the bug

**To Reproduce**
1. Steps to reproduce
2. Commands used
3. What happened

**Expected Behavior**
What should have happened

**Environment**
- OS: [e.g., Ubuntu 22.04]
- OpenCode version: [e.g., 1.2.3]
- kubectl version: [e.g., 1.28.0]
- Kubernetes version: [e.g., 1.28.0]

**Additional Context**
Any other relevant information
```

## Community Guidelines

- Be respectful and constructive
- Help others learn
- Share knowledge generously
- Give credit where due
- Follow the code of conduct

## Recognition

Contributors will be:
- Acknowledged in the README
- Listed in contributor files
- Appreciated by the community!

## Questions?

If you have questions about contributing:
1. Check the README and documentation
2. Look at existing examples
3. Open an issue for discussion
4. Reach out to maintainers

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to making Kubernetes troubleshooting easier for everyone! 🎉
