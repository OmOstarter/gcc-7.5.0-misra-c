#!/usr/bin/env bash

set -euo pipefail

# Avoid blocking while GDB tries to fetch system debuginfo from Ubuntu's
# debuginfod service.  The cc1 binary already contains its own debug info.
unset DEBUGINFOD_URLS

# VS Code's MIEngine passes --tty=/dev/pts/N to GDB.  With GDB 17.1 on
# this system, that leaves the inferior stuck at its initial ptrace stop.
# cc1 does not need interactive input, so remove that argument and let the
# launch configuration redirect the inferior to /dev/null instead.
gdb_args=()
for gdb_arg in "$@"; do
  case "$gdb_arg" in
    --tty=*) ;;
    *) gdb_args+=("$gdb_arg") ;;
  esac
done

exec /usr/bin/gdb -iex "set debuginfod enabled off" "${gdb_args[@]}"
