# Contributing guidelines

The static site generation relies on the open source project [mkdocs](https://www.mkdocs.org/).

## Editing an existing document

To edit an existing piece of documentation, it is sufficient to work directly on the impacted markdown file and follow the [contribution quickstart](./contribution-guidelines.md) to create and publish the pull request.

## Adding a new document and/or folder

Adding a new document and/or folder requires two main steps:

- Add the folder and/or the document under the **docs** folder in the root of the repository
- Add the reference to the new folder in the *nav:* section of **mkdocs.yml** file in the root of the repository

### Example - Add a document called *openscap_profiles.md* in the *security* folder.

- Add the *openscap_profiles.md* file in the **docs/security** folder
- Add the new entry in the *nav:* section of **mkdocs.yml** file:

```
nav:
  - Home: index.md
  - Getting Started:
    - Contributing to the project: contributing.md
  - Security:
    - Welcome to security: security/welcome.md
    - Configure OpenScap Profiles: security/openscap_profiles.md # <------ This is the new entry in the Key: Value format
```

### Example - Add a new section called *Network* and add a *configure_bond.md* file in it

- Create the *network* folder in the **docs** main folder.
- Add the *configure_bond.md* file in the **docs/network** folder
- Add the new entry in the *nav:* section of **mkdocs.yml** file:

```
nav:
  - Home: index.md
  - Getting Started:
    - Contributing to the project: contributing.md
  - Security:
    - Welcome to security: security/welcome.md
  - Network:                                            # <------ Here you define the new section
    - Configure a bond: network/configure_bond.md       # <------ This is the new entry for the file in the 'Key: Value' format
```


