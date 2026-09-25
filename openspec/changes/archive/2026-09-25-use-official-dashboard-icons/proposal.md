## Why

The service dashboard currently identifies linked applications with generic line icons, which makes the destination services less immediately recognizable. The repository also has no declared project license, leaving reuse terms for the dashboard code unclear.

## What Changes

- Use each linked application's official icon in the service dashboard when its license and brand-use terms permit redistribution in this repository.
- Keep a neutral existing fallback icon for an application when official artwork cannot be used or verified.
- Record the provenance, license, and any required attribution for every bundled third-party icon.
- Add an MIT license for this repository's original source code; this does not grant rights to third-party names, logos, or artwork.

## Capabilities

### New Capabilities
- `service-dashboard-branding`: Displays legally reusable official application icons for dashboard links and preserves accessible neutral fallbacks when they are unavailable.
- `project-licensing`: Declares MIT licensing for the repository's original source code while separating third-party asset rights and notices.

### Modified Capabilities

- None.

## Impact

- Affected code: `service-dashboard/index.html`; a new repository-level license and third-party asset provenance/notice documentation may be added.
- Affected services: dashboard links for OpenCode, OmniRoute, DocGen, Codex, and Claude Code.
- External dependencies: official icon source repositories or brand guidelines must be reviewed before any asset is bundled.
