## Context

See `proposal.md` for motivation. The dashboard is a static `service-dashboard/index.html` file served unchanged by a small Node.js HTTP server. It currently contains inline generic SVG line icons for five linked services: OpenCode, OmniRoute, DocGen, Codex, and Claude Code. The repository has no root license file or existing third-party asset notices.

## Goals / Non-Goals

**Goals:**
- Replace generic dashboard artwork only with official assets whose redistribution and brand-use terms are documented and compatible.
- Preserve a usable and recognizable dashboard when an official asset cannot be used.
- Establish clear MIT terms for original repository material without misrepresenting third-party asset rights.

**Non-Goals:**
- Obtaining permissions, licenses, or trademarks not publicly granted by the rights holder.
- Changing linked service endpoints, dashboard startup behavior, or the Docker image's service set.
- Creating or modifying official logos, or implying endorsement by the linked applications.

## Decisions

### Keep assets local and serve them with the dashboard

Approved icons will be copied from authoritative upstream sources into a dedicated dashboard asset directory and referenced by the static page. This keeps the local dashboard available without network access and prevents remote asset availability or privacy behavior from affecting it.

Alternatives considered:
- Remote image URLs: rejected because they add runtime network requests and an external availability dependency.
- Inline copies of external SVG markup: rejected unless the upstream asset terms explicitly permit it; local files retain clearer provenance and make notices easier to audit.

### Require an asset inventory before bundling

Each candidate asset will be assessed against its authoritative source, redistribution license, trademark or brand guidelines, and attribution requirements. A repository notice/inventory will map each bundled icon to these facts. An icon that cannot pass this check will not be bundled.

Alternatives considered:
- Treating open-source application code licenses as logo permissions: rejected because logo and trademark rights can be separate.
- Using third-party icon libraries as substitutes: rejected because the request is for original application icons and substitute artwork would not satisfy it.

### Use neutral fallbacks rather than unverified branding

The existing generic icon treatment will remain available for individual services that have no suitable official asset. Visible service text remains the primary identifier; fallback icons are decorative and will not falsely imply official artwork.

Alternatives considered:
- Omitting the affected service from the dashboard: rejected because availability of a logo must not alter service access.
- Using unofficial fan-made logos: rejected because origin and rights are harder to verify.

### Add MIT at the repository root with explicit asset separation

The root `LICENSE` file will contain the standard MIT License for original repository source and documentation. A concise notice will clarify that third-party branded assets are excluded and governed by their recorded terms.

Alternatives considered:
- Apache-2.0: rejected because the requested MIT license is appropriate for this small configuration and dashboard repository, and patent language does not address the third-party logo rights at issue.
- A custom combined license: rejected because it would be less recognizable and could obscure the distinction between code and third-party assets.

## Risks / Trade-offs

- [Official asset is unavailable or terms are ambiguous] -> Keep the existing neutral fallback for that service and record why no official icon was bundled.
- [Upstream brand guidance changes] -> Keep the inventory's source URLs and review it when dashboard assets change or are updated.
- [SVG asset has unsafe or unnecessary content] -> Inspect and minimize each approved asset before bundling; do not execute scripts or load external resources from icons.
- [A bundled asset requires attribution] -> Place the required attribution in the asset notice/inventory and retain the applicable license text where required.

## Migration Plan

1. Identify the authoritative project or brand source for each linked service's icon and document the rights review.
2. Add only approved assets and wire them into the static dashboard; retain fallbacks for the others.
3. Add the MIT root license and third-party asset notice/inventory.
4. Build the Docker image and load the dashboard locally to verify image delivery, readable labels, links, and fallback behavior.
5. Roll back by restoring the generic icon for any service whose asset review is revoked or found incomplete; no data or service migration is required.
