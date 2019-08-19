#! /usr/bin/env bash
# Copyright (C) 2017 Expat development team
# Licensed under the MIT license

case "x86_64-pc-none" in
*-mingw*)
    exec wine "$@"
    ;;
*)
    exec "$@"
    ;;
esac
