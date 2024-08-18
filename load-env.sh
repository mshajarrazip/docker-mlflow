#! /usr/bin/env bash

# Parse options
extra_env_files=""
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -d|--extra-env-files) extra_env_files="$2"; shift ;;
        -u|--uglify) uglify=1 ;;
        *) echo "Unknown parameter passed: $1"; return 1 ;;
    esac
    shift
done

for env in .env .env-overrides; do
    if ! [ -f $env ]; then
        echo "File ($env) not found .. skipping"
        continue
    fi
    echo "Loading variables from $env"
    while IFS='=' read -r key value; do
        if [[ ! $key =~ ^# && -n $key ]]; then
            # Use eval to expand variables in value safely, ensuring value is properly quoted
            eval value=\"$value\"
            export "$key=$value"
        fi
    done < <(grep -v '^#' $env)
done

# loop through extra_envs and export them
if [ -n "$extra_env_files" ]; then
    echo "Loading extra env files ... "
    for env in ${extra_env_files//;/ }
    do
        if ! [ -f $env ]; then
            echo "File ($env) not found .. skipping"
            continue
        fi
        echo "Loading variables from $env"
        while IFS='=' read -r key value; do
            if [[ ! $key =~ ^# && -n $key ]]; then
                # Use eval to expand variables in value safely, ensuring value is properly quoted
                eval value=\"$value\"
                export "$key=$value"
            fi
        done < <(grep -v '^#' $env)
    done
fi