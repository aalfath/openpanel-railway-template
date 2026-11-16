# OpenPanel API (event ingestion, tRPC, auth). Runs database migrations, then starts.
FROM lindesvard/openpanel-api:2.3.0@sha256:cee4855cd715a7248c5c49090fe93a28ffc505541de20cb238d8884a6bcb9223
# API_HOST=:: listens on IPv4 and IPv6 (Railway's private network).
ENV NODE_ENV=production \
    API_HOST=:: \
    SELF_HOSTED=true \
    ALLOW_REGISTRATION=false \
    ALLOW_INVITATION=true \
    BATCH_SIZE=5000 \
    BATCH_INTERVAL=10000
COPY start.sh /railway-start.sh
CMD ["sh", "/railway-start.sh"]
