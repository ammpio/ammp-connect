#!/bin/bash

check_wg_config.sh

wg-quick up wg0 || true
