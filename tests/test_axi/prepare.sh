#!/bin/bash
set -e

if [ ! -d general-cores ]; then
  git clone https://gitlab.com/ohwr/project/general-cores.git
fi
(cd general-cores && git checkout 63f3671351127a398006e01f66b37adb7eda9a37)

if [ ! -d hdl-modules ]; then
  git clone https://github.com/hdl-modules/hdl-modules.git
fi
(cd hdl-modules && git checkout 0271e3b128e7fec80bb0991c31c294cb38d2cb31)