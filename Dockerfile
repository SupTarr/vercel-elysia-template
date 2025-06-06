FROM oven/bun:1.2.12-alpine as base

LABEL fly_launch_runtime="Bun"

WORKDIR /app
ENV NODE_ENV=production
FROM base as build

COPY --link bun.lockb package.json ./
RUN bun install --ci

COPY --link . .
FROM base
COPY --from=build /app /app

EXPOSE 3000
CMD [ "bun", "run", "start" ]
