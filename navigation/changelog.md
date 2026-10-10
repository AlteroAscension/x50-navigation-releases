# X50 Navigation 0.15.109-route-departure-diagnostics

- Explain route-guided departure decisions in trip journals: all failed checks, compass acceptance and freshness, branch geometry/course errors, and confirmation time/distance.
- Record confirmation resets immediately and ongoing junction/turn checks once per second while the reason stays unchanged.
- Record branch-feed age and route mismatch, steering/motion timing, and along-route phase adjustments.
- Include the current route-guided strategy and shared cached-road implementation from the preceding development builds.
- Departure thresholds and confirmation behavior are unchanged by the diagnostic additions; this release helps identify missed departures during future drives.
- Rooted Magisk + LSPosed release. Rootless was not built or verified.


- Magisk module versionCode: 186
- SHA-256: `307b889084316a25822ceed8978c9ec58826294b3864821afe7016f551657eb3`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.109-route-departure-diagnostics/x50-navigation-magisk-0.15.109-route-departure-diagnostics.zip
