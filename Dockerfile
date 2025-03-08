FROM debian:bookworm-slim

LABEL maintainer="Anthropic"
LABEL description="Claude Code CLI container"
LABEL version="1.0"

RUN apt-get update && apt-get install -y nodejs npm curl \
	&& rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY docker-entrypoint.d/ /docker-entrypoint.d/
RUN chmod +x /docker-entrypoint.sh \
	&& chmod +x /docker-entrypoint.d/*.sh

WORKDIR /app
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["claude"]
