#!/bin/bash

protoc --dart_out=grpc:lib/src/communication/protos/generated -I=$(pwd)/lib/src/communication/protos *.proto
protoc --dart_out=grpc:. -I=$(pwd) lib/src/communication/protos/*.proto
