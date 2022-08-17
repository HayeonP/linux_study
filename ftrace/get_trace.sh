#!/bin/bash
echo 0 > /sys/kernel/debug/tracing/tracing_on
echo "trace off"
sleep 3
cp /sys/kernel/debug/tracing/trace .
mv trace ftrace_log.c
