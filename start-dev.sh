#!/bin/sh
exec erl \
    -pa ebin deps/*/ebin \
    -boot start_sasl \
    -sname erlblog_dev \
    -s erlblog \
    -s reloader
