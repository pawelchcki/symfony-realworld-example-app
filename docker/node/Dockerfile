FROM node:10.15

# Update npm to latest version
RUN npm install -g npm newman

# Set PROJECT USER
RUN groupmod -g 999 node && usermod -u 999 -g 999 node
RUN useradd -ms /bin/bash project
COPY --chown=project:project ./spec /project/spec
RUN chown -R project:project /project

USER project
WORKDIR /project

CMD bash ./spec/api-spec-test-runner.sh
