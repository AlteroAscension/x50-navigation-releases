# X50 Navigation 0.15.68-2gis-overlay

- 2GIS uses its exported read-only dashboard contract for the current road
  limit and nearest camera metadata; speed limits are normalized to km/h.
- The 2GIS overlay's "I am here" action now anchors directly to the selected
  2GIS route and immediately starts system mock-location publication.
- The 2GIS status UI now lives in the app's content layer above its Qt map,
  rather than in the Activity decor layer, so it follows the map UI reliably.
- Protected builds retain the declared 2GIS route bridge provider, preventing
  a startup crash after the module is installed.
- Relay satellite observations remain stable through optional packets that omit
  the field; an explicitly reported zero is still passed through as zero.
- The protected build keeps the reflected Google Fused mock-location API for
  2GIS compatibility on devices where Google Play services are available.
- Magisk module versionCode: 145
- SHA-256: `44e205f907263a8a356622e68cdd009482a9520be6cf15548e7c3fe49eb20b95`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.68-2gis-overlay/x50-navigation-magisk-0.15.68-2gis-overlay.zip