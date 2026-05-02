FROM ghost:6-alpine

USER root

# Copy production config into Ghost's install directory (not the content VOLUME, so it persists)
COPY config.production.json /var/lib/ghost/config.production.json

# Stage theme outside the VOLUME — files COPY'd into a VOLUME path are silently dropped at runtime
COPY content/themes/voice /home/node/voice-theme
RUN chown -R node:node /home/node/voice-theme

# On each container start: fix volume ownership, seed the theme, then hand off to Ghost's own entrypoint.
# Runs as root so it can chown the volume mount; Ghost's entrypoint handles the privilege drop to node.
RUN printf '#!/bin/sh\nset -e\nmkdir -p /var/lib/ghost/content/themes\nchown -R node:node /var/lib/ghost/content\ncp -r /home/node/voice-theme /var/lib/ghost/content/themes/voice\nexec docker-entrypoint.sh "$@"\n' \
    > /usr/local/bin/theme-entrypoint.sh \
    && chmod +x /usr/local/bin/theme-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/theme-entrypoint.sh"]
CMD ["node", "current/index.js"]
