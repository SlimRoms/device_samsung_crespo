#!/sbin/sh
#
# Backup and restore proprietary Android system files
#

C=/tmp/backup
S=/system

# list of gapps-jb-20130813
get_files() {
cat <<EOF
app/ChromeBookmarksSyncAdapter.apk
app/ConfigUpdater.apk
app/GenieWidget.apk
app/Gmail2.apk
app/GmsCore.apk
app/GoogleBackupTransport.apk
app/GoogleCalendarSyncAdapter.apk
app/GoogleContactsSyncAdapter.apk
app/GoogleEars.apk
app/GoogleFeedback.apk
app/GoogleLoginService.apk
app/GoogleOneTimeInitializer.apk
app/GooglePartnerSetup.apk
app/GooglePlus.apk
app/GoogleServicesFramework.apk
app/GoogleTTS.apk
app/LatinImeDictionaryPack.apk
app/MediaUploader.apk
app/NetworkLocation.apk
app/Phonesky.apk
app/QuickSearchBox.apk
app/SetupWizard.apk app/Provision.apk
app/Talkback.apk
app/VoiceSearchStub.apk
etc/permissions/com.google.android.maps.xml
etc/permissions/com.google.android.media.effects.xml
etc/permissions/com.google.widevine.software.drm.xml
etc/permissions/features.xml
etc/preferred-apps/google.xml
etc/g.prop
framework/com.google.android.maps.jar
framework/com.google.android.media.effects.jar
framework/com.google.widevine.software.drm.jar
lib/libAppDataSearch.so
lib/libfilterpack_facedetect.so
lib/libfrsdk.so
lib/libgames_rtmp_jni.so
lib/libgoggles_clientvision.so
lib/libgoogle_recognizer_jni.so
lib/libgtalk_jni.so
lib/libgtalk_stabilize.so
lib/libjni_latinime.so
lib/libjni_t13n_shared_engine.so
lib/libpatts_engine_jni_api.so
lib/libplus_jni_v8.so
lib/librs.antblur_constant.so
lib/librs.antblur_drama.so
lib/librs.antblur.so
lib/librs.drama.so
lib/librs.film_base.so
lib/librs.fixedframe.so
lib/librs.grey.so
lib/librs.image_wrapper.so
lib/librsjni.so
lib/librs.retrolux.so
lib/libRSSupport.so
lib/libspeexwrapper.so
lib/libvcdecoder_jni.so
lib/libvorbisencoder.so
lib/libwebp_android.so
lib/libwebrtc_audio_coding.so
tts/lang_pico/de-DE_gl0_sg.bin
tts/lang_pico/de-DE_ta.bin
tts/lang_pico/es-ES_ta.bin
tts/lang_pico/es-ES_zl0_sg.bin
tts/lang_pico/fr-FR_nk0_sg.bin
tts/lang_pico/fr-FR_ta.bin
tts/lang_pico/it-IT_cm0_sg.bin
tts/lang_pico/it-IT_ta.bin
usr/srec/en-US/c_fst
usr/srec/en-US/classifier
usr/srec/en-US/clg
usr/srec/en-US/compile_grammar.config
usr/srec/en-US/contacts.abnf
usr/srec/en-US/dict
usr/srec/en-US/dictation.config
usr/srec/en-US/dnn
usr/srec/en-US/endpointer_dictation.config
usr/srec/en-US/endpointer_voicesearch.config
usr/srec/en-US/ep_acoustic_model
usr/srec/en-US/g2p_fst
usr/srec/en-US/google_hotword.config
usr/srec/en-US/grammar.config
usr/srec/en-US/hclg_shotword
usr/srec/en-US/hmm_symbols
usr/srec/en-US/hmmlist
usr/srec/en-US/hotword_normalizer
usr/srec/en-US/hotword_word_symbols
usr/srec/en-US/metadata
usr/srec/en-US/norm_fst
usr/srec/en-US/normalizer
usr/srec/en-US/offensive_word_normalizer
usr/srec/en-US/phone_state_map
usr/srec/en-US/phonelist
usr/srec/en-US/rescoring_lm
usr/srec/en-US/wordlist
EOF
}

# script entry - just copy out and copy in
case "$1" in
    backup)
        mount $S

        # Do not backup incompatible version of gapps
        if [ x`sed -ne "/^ro.build.version.release=4.2.*$/p" /system/build.prop` == x'' ]
        then
            echo "imcompatible version of gapps!"
            umount $S
            exit 0
        fi

        rm -rf $C
        mkdir -p $C
        get_files | while read file
        do
            if [ -e $S/$file ]
            then
                echo "backup: $file"
                fname=`echo $file | busybox sed 's!/!_!g'`
                cp -p $S/$file $C/$fname
            fi
        done
        umount $S
        ;;
    restore)
        get_files | while read file
        do
            fname=`echo $file | busybox sed 's!/!_!g'`
            if [ -e $C/$fname ]
            then
                echo "restore: $file"
                cp -p $C/$fname $S/$file
            fi
        done
        rm -rf $C
        ;;
    *)
        echo "Usage: $0 {backup|restore}"
        exit 1
esac

exit 0
