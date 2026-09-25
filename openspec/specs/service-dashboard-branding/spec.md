# service-dashboard-branding Specification

## Purpose

The service dashboard makes linked developer applications recognizable through their official icons where those assets can be lawfully redistributed and used.

## Requirements

### Requirement: Licensed official service icons
The service dashboard SHALL display the official icon for each linked application only when the icon's source, redistribution license, and applicable brand-use terms have been verified as compatible with bundling it in this repository.

#### Scenario: Approved official icon is available
- **WHEN** a linked application's official icon has verified compatible redistribution and brand-use terms
- **THEN** the dashboard displays that official icon beside the application's name

#### Scenario: Official icon cannot be approved
- **WHEN** an official icon lacks verifiable compatible terms or its use is not permitted
- **THEN** the dashboard displays a neutral fallback icon without representing it as official artwork

### Requirement: Icon provenance and attribution
The repository SHALL record the source URL, applicable license or brand-use terms, and any required attribution for every bundled third-party service icon.

#### Scenario: Attribution is required
- **WHEN** a bundled official icon requires attribution or a license notice
- **THEN** the repository includes that required attribution or notice with the asset records

#### Scenario: Icon provenance is reviewed
- **WHEN** a maintainer reviews a bundled service icon
- **THEN** they can identify the icon's source and the terms that authorize its inclusion

### Requirement: Accessible icon presentation
The dashboard SHALL keep each service link identifiable by visible text regardless of whether it displays an official icon or a fallback icon.

#### Scenario: Icon fails to load
- **WHEN** an icon cannot be rendered by the browser
- **THEN** the linked application's visible name and purpose remain available to the user
