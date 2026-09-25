## 1. Asset rights review

- [x] 1.1 Inventory the OpenCode, OmniRoute, DocGen, Codex, and Claude Code dashboard links; locate an authoritative icon source and record its source URL, redistribution license, brand-use terms, and required attribution for each candidate, verifying every entry is complete before an asset is added.
- [x] 1.2 Reject or defer every candidate whose logo rights, license, or brand-use terms cannot be verified; document the decision and verify that each affected service retains a neutral fallback icon.
- [x] 1.3 Inspect every approved SVG or image for scripts, external references, and unnecessary content; retain only safe static assets and verify each file renders locally without a network request.

## 2. Dashboard branding

- [x] 2.1 Add approved official icon files beneath a dedicated `service-dashboard` asset directory and add a provenance/attribution notice or inventory; verify every bundled third-party icon has a source and applicable terms recorded.
- [x] 2.2 Update `service-dashboard/index.html` to display approved local official icons beside their named service links and preserve neutral fallback icons for unapproved services; verify the visible name and purpose remain readable if an icon is unavailable.
- [x] 2.3 Build and start the Docker dashboard, then verify at `http://localhost` that each service link still targets its configured port and that no dashboard icon produces an external runtime request.

## 3. Repository licensing

- [x] 3.1 Determine the appropriate copyright holder and year for the repository, add the complete MIT License as the root `LICENSE` file, and verify the text matches the standard MIT License.
- [x] 3.2 Add a concise third-party asset rights notice that excludes external names, logos, and icons from the repository's MIT grant and points to the asset inventory; verify the notice distinguishes repository code rights from branded-asset terms.

## 4. Validation

- [x] 4.1 Validate the completed OpenSpec change with `openspec validate use-official-dashboard-icons --strict` and resolve every reported issue.
- [x] 4.2 Review the final dashboard in a browser at desktop and narrow viewport widths; verify official and fallback icons align with service labels, keyboard focus remains visible, and all linked services remain identifiable by text.
