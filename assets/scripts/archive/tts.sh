#! /bin/bash
CLIP=$(xclip -o -sel c)

curl -X 'POST' \
  'http://localhost:59125/api/tts?voice=en_US%2Fvctk_low&noiseScale=0.667&noiseW=0.8&lengthScale=1&ssml=false' \
  -H 'accept: */*' \
  -H 'Content-Type: text/plain' \
  -d "$CLIP" | aplay