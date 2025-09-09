# docker github actions runner

## Overview

This repository contains docker images for self-hosting a github actions runner as a docker container. 

## Setup

It is reccommended to use a docker-compose.yml file for managing your container. An example file is provided in this repository.

Create a new folder somewhere and run the following command:
```bash
wget https://raw.githubusercontent.com/Ableytner/docker-github-actions-runner/refs/heads/main/docker-compose.yml
```
Then open up the newly created docker-compose.yml file and replace `myuser` / `myrepo` with your Github username / repository name respectively.

### Token generation

To use the provided images, you need to create a new Github access token, which the runner uses to connect to Github.
To create this token:
* head to https://github.com/settings/personal-access-tokens/new
* Set `Token name` to something descriptive.
* Set `Expiration` to a reasonable value. Tokens without an expiration date ARE NOT RECCOMMENDED!
* For `Permissions`, under `Repositories` you need to add `Administration` and select Read and Write mode.

Depending on whether you want to use this token for only one or multiple repositories, choose `All repositories` or `Only select repositories`.

After generating the token, copy its value and create a new file `.env` in the directory where docker-compose.yml resides.
Add the following content to `.env`:
```text
TOKEN='your-new-token-here'
```

### Organization repository token generation

If you want to add the runner to a repository within an Github organization you own, follow the steps above, but be sure to:
* select your organization as the resource owner
* For `Permissions`, under `Repositories` you need to add `Administration` and select Read and Write mode.

### Organization-level token generation

If you want to add the runner to an Github organization you own, follow the steps above, but be sure to:
* select your organization as the resource owner
* For `Permissions`, under `Organizations` you need to add `Administration` and `Self-hosted runners` and select Read and Write mode for both.

## Usage

To start the containers, run:
```bash
docker compose up -d
```

To display logs:
```bash
docker compose logs
```

To verify that it's working, head to github.com/myuser/myrepo/settings/actions/runners and you should see two runners.

To stop the containers:
```bash
docker compose down
```

## Environment Variables

The following environment variables are supported for this image:

| name | description | required | example value | default value |
| --- | --- | --- | --- | --- |
| REPO | the repository the runner should be added to | yes* | myusername/myrepo | / |
| ORG | the organization the runner should be added to | yes* | myorganization | / |
| TOKEN | token for authenticating against the Github API | yes | github_pat_XXX... | / |
| RUNNER_NAME | the runners' name (the container hostname is always appended) | no | selfhosted-docker-runner | runner-ubuntu |
| EXTRA_LABELS | any extra labels for the runner | no | docker,nonroot,example | / |

\* only one option can be provided
