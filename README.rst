Self-Contained Sming Environment
================================

Out-Of-The-Box Setup
====================

(This will automatically setup a local, standalone dev environment that includes Sming, ESP SDK and toolchain.)

::

    # 1) git clone this repo
    # 2) cd to the repo root
    ./setup.sh

Build
=====

::

    # at the repo root
    ./build.sh

Flash
=====

::

    # at the repo root
    # make sure the device is at /dev/ttyUSB0 and your current user has write permission
    ./flash.sh

Tweaks
======

Change ``ESP_HOME`` setup in ``env.sh`` to your own ESP path.
