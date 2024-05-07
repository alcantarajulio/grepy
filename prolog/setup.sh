#!/usr/bin/env bash

SRC_GREPY="${HOME}/.local/src_grepy"

mkdir -p "${SRC_GREPY}"
cp src/* "${SRC_GREPY}"
cp grepy "${HOME}/.local/bin/"
