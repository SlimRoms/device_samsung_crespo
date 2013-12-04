# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file is the build configuration for a full Android
# build for crespo hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps).
#

# Inherit from those products. Most specific first.
$(call inherit-product, device/samsung/crespo/full_crespo.mk)

# Boot animation
TARGET_SCREEN_HEIGHT := 800
TARGET_SCREEN_WIDTH := 480

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

# Discard inherited values and use our own instead.
PRODUCT_NAME := slim_crespo
PRODUCT_DEVICE := crespo
PRODUCT_BRAND := Google
PRODUCT_MODEL := Nexus S
PRODUCT_MANUFACTURER := Samsung
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=soju \
    BUILD_FINGERPRINT="google/soju/crespo:4.1.2/JZO54K/485486:user/release-keys" \
    PRIVATE_BUILD_DESC="soju-user 4.1.2 JZO54K 485486 release-keys"