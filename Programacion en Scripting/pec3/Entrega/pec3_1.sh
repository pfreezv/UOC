#!/bin/bash

grep -E "[1-9][0-9],F,[1,3][0-9],finnish,.*spanish" demographic_info.csv | grep -E "french"
