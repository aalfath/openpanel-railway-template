# OpenPanel dashboard (web UI). Talks to the API; holds no database credentials.
FROM lindesvard/openpanel-dashboard:2.3.0@sha256:b773cf864454a0ec89b2a133b48bf06202880ed650a75cc2f1f5c87aaed1cffa
ENV NODE_ENV=production \
    SELF_HOSTED=true
CMD ["node", ".output/server/index.mjs"]
