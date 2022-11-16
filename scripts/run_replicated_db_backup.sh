#!/usr/bin/env bash

replicatedctl app-config export --hidden | jq -r '.generated_postgres_password.value' > /mnt/tfe/generated_postgres_password.txt
