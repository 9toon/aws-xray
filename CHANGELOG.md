# CHANGELOG
Only breaking or notable changes.

## v0.39.0
- `ErrorHandlerWithSentry` now supports `sentry-ruby` gem.

## v0.38.0
- aws/xray/hooks/active_record was removed because it's not usable due to too many traces

## v0.34.0
- Change default sampling rate from 0.1% to undefined. Please set proper sampling rate in your production system.

## v0.31.0
- Rename tracing methods while keeping old methods:
  - `#base_trace` -> `#start_segment`
  - `#child_trace` -> `#start_subsegment`

## v0.30.0
- Drop faraday dependency. Users who want to use Faraday middleware must require `aws/xray/faraday`.
