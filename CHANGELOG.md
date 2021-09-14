# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.4.1] - 2021-09-14

### Fixed
- Fixed ingress definitions for WS and HTTP traffic when namespaced
- Fixed bug when rendering the authentication method value for the web application

## [0.4.0] - 2021-09-10

### Changed
- Allow OAuth2 configuration to be dynamic based on a single provider

## [0.3.1] - 2021-08-27

### Added
- Added context variables for the web and API deployment variables

### Fixed
- Fixed missing context with ingress templates
- Apply context path to web app deployment

## [0.3.0] - 2021-08-17

### Added
- Added `certificateRef` parameter to allow override of container CA Certificates
- Added `certificate` parameter to allow database certificate to be provided for verification

### Fixed
- Fixed referenced database for API and Webapp services

## [0.2.0] - 2021-08-13

### Added
- Added database per service configuration
- Added context variable for ViziVault
- Added OAuth2 configuration for ViziVault
- Added SSL parameter for RabbitMQ

### Changed
- Made application initializers optional
- Refactored MongoDB parameters to build and provide URI to deployments

## [0.1.0] - 2021-05-12

### Added
- Initial chart for local installation of the platform
