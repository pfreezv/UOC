#!/bin/bash

sed -e 's/\b\(.\)/\u\1/7' demographic_info.csv
