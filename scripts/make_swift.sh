#!/bin/sh

gyb() {
  DIR="$(dirname "$1")"
  FILE="$(basename "$1" .gyb)"
  ./scripts/gyb.py "$1" --line-directive "" > "$DIR/$FILE"
}

gyb Sources/JSONBuildKit/BuildTypes.swift.gyb
#gyb Sources/JSONKit/JSON+Decoded.swift.gyb
#gyb Sources/JSONKit/JSON+KeyedDecoded.swift.gyb
#gyb Sources/JSONKit/JSONStream+Write.swift.gyb
#gyb Tests/JSONKitTests/JSONStreamTests+Write.swift.gyb
