#!/bin/bash

ip addr | grep -o "10\.0\.17\.[0-9]\{1,3\}" | grep -v 255
