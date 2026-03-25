# my-app

A full-stack monorepo with NestJS API, Next.js web app, and Fumadocs documentation site.

## Stack

| App         | Framework                        | Port |
| ----------- | -------------------------------- | ---- |
| `apps/api`  | NestJS 11                        | 8000 |
| `apps/web`  | Next.js 16 + React 19 + Tailwind | 3000 |
| `apps/docs` | Next.js 16 + Fumadocs            | 3030 |

**Shared packages:**

- `@workspace/ui` — shared React component library (shadcn/ui)
- `@workspace/eslint-config` — shared ESLint config
- `@workspace/typescript-config` — shared TypeScript config
- `@workspace/backend-config` — shared NestJS config

**Tooling:** Turborepo · pnpm · TypeScript · ESLint · Prettier · Husky

## Requirements

- Node.js >= 20
- pnpm >= 10.4.1

## Getting started

```bash
# Install dependencies
pnpm install

# Start all apps in dev mode
pnpm dev
```

## Commands

```bash
pnpm dev          # Start all apps in development mode
pnpm build        # Build all apps
pnpm lint         # Lint all apps
pnpm format       # Format all files with Prettier
pnpm format:check # Check formatting
```

## Environment variables

Copy `.env.dev` and adjust as needed:

```bash
cp .env.dev .env
```

Key variables:

```env
PORT_API=8000
PORT_WEB=3000
PORT_DOCS=3030
DATABASE_URL=postgresql://user:password@localhost:5432/myapp
```

## Adding UI components

```bash
# Add a shadcn/ui component to the web app
pnpm dlx shadcn@latest add button -c apps/web
```

Components are placed in `packages/ui/src/components` and can be imported anywhere:

```tsx
import { Button } from '@workspace/ui/components/button';
```

## Project structure

```
my-app/
├── apps/
│   ├── api/        # NestJS backend
│   ├── web/        # Next.js frontend
│   └── docs/       # Fumadocs documentation
├── packages/
│   ├── ui/         # Shared component library
│   ├── eslint-config/
│   ├── typescript-config/
│   └── backend-config/
├── turbo.json
└── pnpm-workspace.yaml
```
