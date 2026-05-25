/**
 * Minimal platform-target definitions extracted from mizuchi's `config.ts`.
 *
 * The full mizuchi config module pulls in YAML/zod and a lot of orchestration
 * settings we don't need here. The asm parser only consumes the type + the
 * two `isXxxPlatform()` helpers, so those are inlined verbatim.
 */

/**
 * Supported platform targets
 */
export const platformTargets = [
  'gba',
  'nds',
  'n3ds',
  'n64',
  'gc',
  'wii',
  'ps1',
  'ps2',
  'psp',
  'win32',
  'switch',
  'android_x86',
  'irix',
  'saturn',
  'dreamcast',
] as const;
export type PlatformTarget = (typeof platformTargets)[number];

export const isArmPlatform = (target: PlatformTarget): boolean => {
  return target === 'gba' || target === 'nds' || target === 'n3ds' || target === 'switch';
};

export const isMipsPlatform = (target: PlatformTarget): boolean => {
  return target === 'irix' || target === 'n64' || target === 'ps1' || target === 'ps2' || target === 'psp';
};
