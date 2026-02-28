# Design considerations

Here we try to describe good practices related to running AI agents against Red Hat Enterprise Linux systems.
As this space is under agressive development, we expect this page to be continously undergoing development.

## MCP vs. Non-MCP

When running AI agents against Red Hat Enterprise Linux (RHEL) systems, there are in general two different ways that you can do that.

1. Direct integration: Having the agent run on a local RHEL system, and integrate to the Linux subsystem through directly.
2. MCP integration: Having the agent talk to RHEL instances through a MCP services.

Let's unpack the two options.

## **Direct integration**

If you have an agent installed on your local system, it's no uncommon that it talks directly to your RHEL system. This by itself is not an issue, but let's see in detail what it means.

### Access

When for example using RHEL Lightspeed, aka the command line assistant, aka "c", or a local installation of Claude CLI, you have an agent running on your RHEL instance. In our examples of RHEL Lightspeed or Claude CLI, the agent runs with the priviledges of that user. That means that any commands that your user can run, are potential commands which your agent can use. In the case of RHEL Lightspeed, the agent is limited to what it is allowed to do, but this is not always the case, across other AI agents and should be considered carefully.

If the agent would having suid bit or similiar privieledge, it may run with more priviledges than the user. This would in general terms be very risky and advised against.

### Audit trail

When commands are run in a local terminal session, audit trails are commonly more limited, if you are not recording the terminal session/interaction, and/or have very agressive audit rules in place.

### Life Cycle management

If your agent have direct integration to the underlying operating system, you need to consider the stability of the underlying interfaces it's using. In the case of RHEL Lightspeed, it's developed with Red Hat Enterprise Linux in mind, and is tested specifically against Red Hat Enterprise Linux. At the same time, the Red Hat Enterprise Linux ABI provides increased stability across minor and even major releases. If you are using a third party agent, you would need to ensure yourself that it can properly talk to the underlying Linux subsystems in the case of updates of either agent or operating system.

## **MCP integration**

If you have an agent which talks to your RHEL instances via a MCP server, it means that the agent's interactions are all funneled through the MCP server. There are multiple MCP servers which has support for Linux in general and Red Hat Enterprise Linux specifically. In general, MCP servers can also both run locally where the agent resides, centrally on a server or locally on a managed system. You would start by considering what is right and available to you. These different options have some specific implications as it relates to the topics below. If you use the RHEL Lightspeed Linux MCP server, the MCP server runs locally with the agent, and access is in such a way guarded.
Let's understand what it means.

### Access

MCP servers will be configured with users and systems for them communicate with. If we take the example of RHEL Lightspeed's [Linux MCP server](https://rhel-lightspeed.github.io/linux-mcp-server/) you can define specific SSH keys and users for each system which the MCP server is allowed to talk to. Consider what access is suitable to provide for your agent. In general terms, view your agents as a person and design RBAC accordingly.

### Audit trail

The MCP server audit trail is decided by what MCP server solution you choose. Read up on what logging settings are available to you. If we take the exmaple of RHEL Lightspeed's [Linux MCP server](https://rhel-lightspeed.github.io/linux-mcp-server/) the MCP server runs as a local container or binary, which can log details about agent sessions to a local log directly you setup.
Furthermore, the Linux MCP server allows settings such as --log-level, --log-retention-days and --alowed-log-paths. To understand how this works on a detailed level, you can review the responsible [logging_config.py](https://github.com/rhel-lightspeed/linux-mcp-server/blob/main/src/linux_mcp_server/logging_config.py) component in the upstream [Linux MCP server GitHub repository](https://github.com/rhel-lightspeed/linux-mcp-server/).

### Life Cycle management

Updating the MCP server, directly impacts the agents ability to talk to and interact with your systems. If the MCP server runs locally with your agent, as is the case for RHEL Lightspeed's [Linux MCP server](https://rhel-lightspeed.github.io/linux-mcp-server/) then each agent instance will have a MCP server whose lifecycle needs to be managed.
In the case of the Linux MCP server, you can get the MCP server as a part of a container, which means that Life Cycle management is simplified as you then can update the MCP server by simply updating the container which is pulled by your agents.

## Red Hat Enterprise Linux design considerations

When agents talks to your system, there are a number of RHEL subsystems which are of interest to you, as they can in different ways confine what agents can and cannot do on your systems. Crafting policy which limits your agents is a good practice, as if you do not have humans in the loop for what agents do, you need policy to restrict what information can be consumed and what actions are possible to do on  system. Allowing unrestricted root access on a system is not something you should do outside of a restricted local lab environment.

A good starting point for your design is to read the [RHEL Security hardening guide](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/security_hardening/index), in full.

### User management

Overall, a good practice is to apply the same user management processes as you do with any other type of system integration. Use service accounts which are subject to RBAC and apply the principle of least privilege.

### sudo

You can use sudo to manage what commands a user is allowed to run. [Read more about that for RHEL here.](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/security_hardening/managing-sudo-access)

### SELinux

A very powerful way to restrict users and process is using SELinux, a mandatory access system which has the Linux kernel limit what is possible to do in a system. [Read more about SELinux in RHEL here](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/using_selinux/index)

### FApolicyd

You can use FApolicyd in Red Hat Enterprise Linux to create a white or blacklist for what can be run in your system. [Read more about FApolicyd in RHEL here](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/security_hardening/blocking-and-allowing-applications-by-using-fapolicyd)

### CGroups

You can use CGroups in Red Hat Enterprise Linux to limit resource utilization in your system. A good reading starting point is "A Linux sysadmin's introduction to CGroups"](https://www.redhat.com/en/blog/cgroups-part-one)

### Auditd

To get a detailed audit trail of what information your agents are accessing and what commands they run, you can enable auditd to generate a detailed audit trail. [Read more about Auditd in RHEL here](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/risk_reduction_and_recovery_operations/auditing-the-system)