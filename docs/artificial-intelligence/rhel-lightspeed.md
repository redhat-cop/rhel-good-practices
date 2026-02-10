# Command Line Assistant - RHEL Lightspeed

Command Line Assistant (CLA) is part of RHEL Lightspeed (link) and it is an AI Assistant, augmented with Red Hat Documentation, KB Articles, best practices, available for installation since RHEL 9.6 and RHEL 10.0.

This article wants to highlight some best practices and suggestions to make an effective and safe use of this technology.

## Main use cases for Command Line Assistant - RHEL Lightspeed

CLA usage can support junior and seasoned sysadmins in their day-by-day job, but not only that!

It can be a good partner to:

- Troubleshoot issues and analyze logs
- Generate scripts to automate or simplify complex and repetitive tasks
- Guide to hardened systems, analyzing the current configurations and settings
- Be a strong support when learning or experimenting with new tools or features.

In the next sections, we will provide some suggestions on how to use CLA in an efficient and secure way.

## Providing context to Command Line Assistant - RHEL Lightspeed

Context is crucial for LLMs and so it is for Command Line Assistant - RHEL Lightspeed, and it can drastically increase the accuracy of its answers.

RHEL Lighspeed provides multiple ways of providing context:


### Terminal recording

Not enabled by default, terminal recording allows caching all input/output of the terminal session for the user, and you can ingest the content of the previous N lines, by using the argument "-w N".

```
c "Can you analyze the error I got?" -w 5
```

### Passing a file as context

Very powerful when analyzing configuration files, logs or settings. It can be triggered by using the "-a FILE_PATH" argument. 
Be aware that the current limit is 32KB of content.

```
c "Can you help me review the settings for my SSHD service and highlight security flaws?" -a /etc/sshd/sshd_config
```

### Piping the output of commands directly into "c"

Handy when troubleshooting or further parsing of applications/scripts/commands is needed.

```
firewall-cmd --list-all-zones | c "Can you help me summarize the firewall configuration for my zones?"
```

## Some guardrails for a safe adoption

While having an always-on assistant is an advantage, any AI-Generated content should never be used without proper verification and checks.

### No blind copy/paste of configurations/commands

It could be tempting, but blindly utilizing AI-Generated content is generally NOT safe for any environment outside sandboxed scenarios.

### Test the suggestions and generated code/commands in a sandbox

Any configuration or command should be tested in a scenario disconnected from productive environments to avoid any possible issues.

### Do not share sensitive information

While Red Hat doesn't use your data to train or augment the model, history might be saved locally, and in connected scenario (the default for Command Line Assistant - RHEL Lightspeed) data needs to transit from the client to the model serving backend.
Although there is a secure connection in place, the suggestion is to always avoid sharing sensitive information with Command Line Assistant - RHEL Lightspeed.

