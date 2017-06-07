#!/usr/bin/env bash
if [  "true" == "$run_jobs" ]; then
    $1
else
    exit 1;
fi