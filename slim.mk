# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
# This is where we'd set a backup provider if we had one
#$(call inherit-product, device/sample/products/backup_overlay.mk)
$(call inherit-product, device/samsung/crespo/device.mk)

# Inherit some common stuff.
$(call inherit-product, vendor/slim/config/common_full_phone.mk)

# Inherit some common stuff.
$(call inherit-product, vendor/slim/config/gsm.mk)

# Inherit device settings
$(call inherit-product, vendor/slim/config/common_nexus.mk)

# Inherit torch settings
$(call inherit-product, vendor/slim/config/common_ledflash.mk)

#set camera info
PRODUCT_PROPERTY_OVERRIDES += \
    ro.camera.res=5MP

# Release name
PRODUCT_RELEASE_NAME := crespo

# Use build.prop values similar to Google's values
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=soju \
    BUILD_FINGERPRINT="google/soju/crespo:4.1.2/JZO54K/485486:user/release-keys" \
    PRIVATE_BUILD_DESC="soju-user 4.1.2 JZO54K 485486 release-keys" \
    BUILD_NUMBER=485486

PRODUCT_NAME := slim_crespo
PRODUCT_DEVICE := crespo
PRODUCT_BRAND := Google
PRODUCT_MODEL := Nexus S
PRODUCT_MANUFACTURER := Samsung
