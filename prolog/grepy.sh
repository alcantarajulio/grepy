#!/usr/bin/env bash


swipl -g main -t halt main.pl -- "$@" 2> /dev/null