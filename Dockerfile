FROM ghost:6-alpine

USER root

# Stage theme outside the VOLUME — files COPY'd into a VOLUME path are silently dropped at runtime
COPY content/themes/voice /home/node/voice-theme
RUN chown -R node:node /home/node/voice-theme

# On each container start: seed the theme into the content volume, then hand off to Ghost's own entrypoint
RUN printf '#!/bin/sh\nset -e\nmkdir -p /var/lib/ghost/content/themes\ncp -r /home/node/voice-theme /var/lib/ghost/content/themes/voice\nexec docker-entrypoint.sh "$@"\n' \
    > /usr/local/bin/theme-entrypoint.sh \
    && chmod +x /usr/local/bin/theme-entrypoint.sh

USER node

ENTRYPOINT ["/usr/local/bin/theme-entrypoint.sh"]
CMD ["node", "current/index.js"]
