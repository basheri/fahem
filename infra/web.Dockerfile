# Fahem AI web image (Next.js).
# syntax=docker/dockerfile:1
FROM node:22-slim AS base
ENV PNPM_HOME=/pnpm
ENV PATH="${PNPM_HOME}:${PATH}"
RUN corepack enable

WORKDIR /app

# Install workspace dependencies using the lockfile.
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY apps/web/package.json apps/web/package.json
RUN pnpm install --frozen-lockfile

# Build the app.
COPY apps/web/ apps/web/
RUN pnpm --filter web run build

EXPOSE 3000
CMD ["pnpm", "--filter", "web", "run", "start"]
