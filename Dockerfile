from node:18-slim
# version arg contains current git tag
# install git
RUN apt-get update && apt-get install -y git
# install it
COPY . /tmp/npm/
RUN cd /tmp/npm && npm install && npm install --global
# run it
CMD tardis-machine --cache-dir=/.cache
