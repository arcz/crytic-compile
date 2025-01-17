#!/usr/bin/env bash

### Test embark integration

cd /tmp

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
source ~/.nvm/nvm.sh
nvm install --lts
nvm use --lts
npm --version

npm install -g embark
embark demo
cd -
cd /tmp/embark_demo
npm install
crytic-compile . --embark-overwrite-config --compile-remove-metadata
cd -

DIFF=$(diff /tmp/embark_demo/crytic-export/contracts.json ../../tests/expected/embark-demo.json)
if [ "$DIFF" != "" ]
then  
    echo "Embark test failed"
    echo $DIFF
    exit -1
fi


