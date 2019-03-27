FROM node:10.15

# Update npm to latest version
RUN npm install -g npm newman dd-trace

# Set PROJECT USER
RUN groupmod -g 999 node && usermod -u 999 -g 999 node
RUN useradd -ms /bin/bash project
COPY --chown=project:project ./spec /project/spec
RUN chown -R project:project /project

USER project
WORKDIR /project

COPY docker/node/index.js /usr/local/lib/node_modules/newman/index.js
CMD bash ./spec/api-spec-test-runner.sh
