#!/usr/bin/env bash

# Build quarto-julia
docker build \
    --file quarto-julia.txt \
    --tag quarto-julia:latest \
    --tag quarto-julia:julia-1.9.3 \
    --tag quarto-julia:python-3.11 \
    .

# Build quarto-julia-vscode
# docker build \
#     --file quarto-julia-vscode.txt \
#     --tag quarto-julia-vscode:latest \
#     --tag quarto-julia-vscode:julia-1.9.3 \
#     --tag quarto-julia-vscode:python-3.11 \
#     .
