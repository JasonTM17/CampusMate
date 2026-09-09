# Build from repository root:
# docker build -f server/Dockerfile -t campusmate-server .

# Build stage
FROM dart:stable AS build

WORKDIR /app
COPY pubspec.yaml .
COPY pubspec.lock .
COPY packages/ packages/
COPY server/ server/

RUN dart pub get

WORKDIR /app/server
RUN dart compile exe bin/main.dart -o bin/server

# Add a fallback for possibly missing directories
RUN mkdir -p config web migrations lib/src/generated

# Final stage
FROM debian:bookworm-slim
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/*

ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith

LABEL org.opencontainers.image.source="https://github.com/JasonTM17/CampusMate"
LABEL org.opencontainers.image.description="CampusMate Serverpod Monolith Backend"
LABEL org.opencontainers.image.licenses="MIT"

# Copy compiled server executable
COPY --from=build /app/server/bin/server server

# Copy configuration files and resources
COPY --from=build /app/server/config/ config/
COPY --from=build /app/server/web/ web/
COPY --from=build /app/server/migrations/ migrations/

# This file is required to enable the endpoint log filter in Insights.
COPY --from=build /app/server/lib/src/generated/protocol.yaml lib/src/generated/protocol.yaml

# Expose ports
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

# Define the entrypoint command
ENTRYPOINT ["sh", "-c", "./server --mode=$runmode --server-id=$serverid --logging=$logging --role=$role"]
