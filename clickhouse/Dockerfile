# ClickHouse for OpenPanel's events, with upstream's OpenPanel settings.
FROM clickhouse/clickhouse-server:25.10.2.65@sha256:e019438e1e0539b0d1ce8380b628f1c06c5a0e641f368fc746acf4a8cf48d2f2
COPY op-config.xml /etc/clickhouse-server/config.d/op-config.xml
COPY op-user-config.xml /etc/clickhouse-server/users.d/op-user-config.xml
ENV CLICKHOUSE_DB=openpanel \
    CLICKHOUSE_USER=openpanel
