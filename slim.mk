$(call inherit-product, device/samsung/crespo/full_crespo.mk)

# Inherit some common stuff.
$(call inherit-product, vendor/slim/config/common_full_phone.mk)

# Inherit some common stuff.
$(call inherit-product, vendor/slim/config/gsm.mk)

# Inherit device settings
$(call inherit-product, vendor/slim/config/common_nexus.mk)

#copy kernel and modules
PRODUCT_COPY_FILES += \
	device/samsung/crespo/prebuilt/boot.img:system/slimkernel/boot.img \
	device/samsung/crespo/prebuilt/system/etc/init.d/98mounts:system/etc/init.d/98mounts \
	device/samsung/crespo/prebuilt/system/lib/libOMX.SEC.AVC.Decoder.so:system/lib/libOMX.SEC.AVC.Decoder.so \
	device/samsung/crespo/prebuilt/system/lib/libOMX.SEC.AVC.Encoder.so:system/lib/libOMX.SEC.AVC.Encoder.so \
	device/samsung/crespo/prebuilt/system/lib/libOMX.SEC.M4V.Decoder.so:system/lib/libOMX.SEC.M4V.Decoder.so \
	device/samsung/crespo/prebuilt/system/lib/libOMX.SEC.M4V.Encoder.so:system/lib/libOMX.SEC.M4V.Encoder.so \
	device/samsung/crespo/prebuilt/system/lib/libSEC_OMX_Core.so:system/lib/libSEC_OMX_Core.so \
	device/samsung/crespo/prebuilt/system/lib/libstagefright_omx.so:system/lib/libstagefright_omx.so \
	device/samsung/crespo/prebuilt/system/lib/hw/lights.s5pc110.so:system/lib/hw/lights.s5pc110.so \
	device/samsung/crespo/prebuilt/system/modules/scsi_wait_scan.ko:system/modules/scsi_wait_scan.ko	

#bootanimation
PRODUCT_COPY_FILES +=  \
    vendor/slim/prebuilt/hdpi/bootanimation.zip:system/media/bootanimation.zip

#set camera info
PRODUCT_PROPERTY_OVERRIDES += \
    ro.camera.res=5MP

#copy 00check
PRODUCT_COPY_FILES += \
	vendor/slim/prebuilt/common/etc/init.d/00check:system/etc/init.d/00check

# Release name
PRODUCT_RELEASE_NAME := NS

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=soju BUILD_FINGERPRINT="google/soju/crespo:4.1.2/JZO54K/485486:user/release-keys" 
PRIVATE_BUILD_DESC="soju-user 4.1.2 JZO54K 485486 release-keys"

PRODUCT_NAME := slim_crespo
PRODUCT_DEVICE := crespo
PRODUCT_BRAND := Google
PRODUCT_MODEL := Nexus S
PRODUCT_MANUFACTURER := Samsung
