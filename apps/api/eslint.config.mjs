// @ts-check
import { config as nestConfig } from '@workspace/eslint-config/nest';
import globals from 'globals';

export default [
  ...nestConfig,
  {
    ignores: ['eslint.config.mjs', 'dist/**'],
  },
  {
    languageOptions: {
      globals: {
        ...globals.node,
        ...globals.jest,
      },
      sourceType: 'commonjs',
    },
    rules: {
      '@typescript-eslint/no-floating-promises': 'warn',
      '@typescript-eslint/no-unsafe-argument': 'warn',
    },
  },
];
