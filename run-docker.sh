#!/bin/bash

docker run --rm -it \
      	   -v /build/mx6sl/8/:/build/mx6sl/8/ \
	   --entrypoint bash ubuntu-18-04-mx6sl-android-oreo
