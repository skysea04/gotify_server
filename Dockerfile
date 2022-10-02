FROM amd64/debian:stable-slim
ENV GOTIFY_SERVER_PORT="8080"
WORKDIR /app
COPY ui/build /ui/build/.
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -yq \
  tzdata \
  curl \
  && rm -rf /var/lib/apt/lists/*
ADD gotify-app /app/
# HEALTHCHECK --interval=30s --timeout=5s --start-period=5s CMD curl --fail http://localhost:${GOTIFY_SERVER_PORT}/health || exit 1
EXPOSE 8080
ENTRYPOINT ["./gotify-app"]
