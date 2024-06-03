from node:18-slim
# version arg contains current git tag
# install git
RUN apt-get update && apt-get install -y git curl bc
# install it
COPY tsconfig.json /tmp/npm/
COPY package.json /tmp/npm/
COPY bin /tmp/npm/bin
COPY src /tmp/npm/src
COPY test /tmp/npm/test
RUN cd /tmp/npm && npm install && npm install --global
# run it
ADD readiness.sh /
CMD tardis-machine --cache-dir=/.cache
