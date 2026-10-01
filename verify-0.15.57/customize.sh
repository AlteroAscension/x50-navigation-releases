#!/system/bin/sh
ui_print "- Installing X50 Navigation"
ui_print "- Enable the module for Yandex Navigator in LSPosed after reboot"
chmod 0755 "$MODPATH/service.sh"

# Android 9 forgets ordinary UsbManager grants after a reboot/replug.  Declare
# Navigation as the *default handler* only for the explicitly supported u-blox
# 7 USB receiver (1546:01A7); UsbService will grant that default on attach.
# This is not a broad USB permission and does not touch other accessories.
USB_SETTINGS=/data/system/users/0/usb_device_manager.xml
USB_PACKAGE=ru.lesnik.x50navigation
if [ -f "$USB_SETTINGS" ] && ! grep -q "package=\"$USB_PACKAGE\"" "$USB_SETTINGS"; then
  USB_TMP="$USB_SETTINGS.x50tmp"
  sed 's#</settings>#    <preference package="ru.lesnik.x50navigation" user="0">\n        <usb-device vendor-id="5446" product-id="423" class="0" subclass="0" protocol="0" manufacturer-name="u-blox AG - www.u-blox.com" product-name="u-blox 7 - GPS/GNSS Receiver" serial-number="null" />\n    </preference>\n</settings>#' "$USB_SETTINGS" > "$USB_TMP"
  if grep -q "ru.lesnik.x50navigation" "$USB_TMP"; then
    chown system:system "$USB_TMP" 2>/dev/null
    chmod 0600 "$USB_TMP" 2>/dev/null
    mv "$USB_TMP" "$USB_SETTINGS"
    restorecon "$USB_SETTINGS" 2>/dev/null || true
    ui_print "- Registered automatic USB access for u-blox 7 (1546:01A7)"
  else
    rm -f "$USB_TMP"
    ui_print "! Could not register automatic USB access; manual Connect remains available"
  fi
fi
true
