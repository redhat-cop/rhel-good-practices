# Using Claude CLI with Red Hat Enterprise Linux
This article outlines how to get started with Claude CLI and Red Hat Enterprise Linux. 

# Installation
To install Claude CLI on Red Hat Enterprise Linux, see the [Claude QuickStart](https://code.claude.com/docs/en/quickstart).
TL;DR to install the CLI for Claude, run:
```
curl -fsSL https://claude.ai/install.sh | bash
```

## Ignoring trusted TLS certificates
If you are connecting Claude to MCP servers which do not provide a trusted TLS certificate, you can run the CLI with instructions to ignore that by running:

```
alias claude="NODE_TLS_REJECT_UNAUTHORIZED=0 claude"
```

If you want to make that permanent, create an alias for the Claude CLI which set's this:

```
echo 'alias claude="NODE_TLS_REJECT_UNAUTHORIZED=0 claude"' >>~/.bashrc
bash
```

# Using Claude CLI
There are two different ways Claude CLI can integrate to Red Hat Enterprise Linux.

1) Locally, from a local installation of Claude CLI to the local Red Hat Enterprise Linux instance.
2) Via MCP, from a central installation of Claude CLI, Desktop or etc - to remote Red Hat Enterprise Linux instances MCP servers.

So let's review the two options.

## Local integration
The most simple but also most limited way to get started is to install Claude CLI on a Red Hat Enterprise Linux server.
You can then without further configuration prompt Claude to execute commands and extract information from Red Hat Enterprise Linux with the user you are logged in as.

## MCP integration
The best practice way to have Cluade (or any 3rd party AI tool) to integrate to Red Hat Enterprise Linux is to use the MCP server which Red Hat Enterprise Linux is shipped with.
For more information about [how to setup RHEL and MCP, see this blog](https://www.redhat.com/en/blog/smarter-troubleshooting-new-mcp-server-red-hat-enterprise-linux-now-developer-preview).


