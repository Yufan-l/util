#!/bin/bash

MAIN_CLASS=YOUR_MAIN_CLASS
BIN_DIR=YOUR_JAR_LOCATION
CONFIG=YOUR_CONFIG_LOCATION

ARGS=""

exec java $ARGS -cp "$BIN_DIR/*" $MAIN_CLASS $CONFIG
