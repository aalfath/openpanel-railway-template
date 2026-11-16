# OpenPanel worker (queues, event batching, scheduled jobs).
FROM lindesvard/openpanel-worker:2.3.0@sha256:b22e247fb6980b820c1a954d0e3d2fe88b3edf40a58aa53329467af239538e80
ENV NODE_ENV=production \
    SELF_HOSTED=true \
    ALLOW_REGISTRATION=false \
    ALLOW_INVITATION=true \
    BATCH_SIZE=5000 \
    BATCH_INTERVAL=10000
CMD ["node", "dist/index.js"]
