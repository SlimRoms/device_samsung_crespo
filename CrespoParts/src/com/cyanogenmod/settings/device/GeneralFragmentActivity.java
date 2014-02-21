/*
 * Copyright (C) 2011 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.cyanogenmod.settings.device;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.CheckBoxPreference;
import android.preference.ListPreference;
import android.preference.Preference;
import android.preference.Preference.OnPreferenceClickListener;
import android.preference.PreferenceActivity;
import android.preference.PreferenceFragment;
import android.preference.PreferenceManager;
import android.preference.PreferenceScreen;
import android.util.Log;
import android.view.View;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.widget.TextView;

import com.cyanogenmod.settings.device.R;

public class GeneralFragmentActivity extends PreferenceFragment {

    private static final String TOUCHKEY_NOTIFICATION_FILE = "/sys/class/misc/backlightnotification/enabled";
    private static final String FAST_CHARGE_FILE = "/sys/kernel/fast_charge/force_fast_charge";
    private static final String PREF_ENABLED = "1";
    private static final String TAG = "CrespoParts_General";

    private CheckBoxPreference mNotification;
    private CheckBoxPreference mFastcharge;
    private VibrationPreference mVibration;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        addPreferencesFromResource(R.xml.general_preferences);

        PreferenceScreen prefSet = getPreferenceScreen();
        mNotification = (CheckBoxPreference) findPreference(DeviceSettings.KEY_NOTIFICATION);
        mFastcharge = (CheckBoxPreference) findPreference(DeviceSettings.KEY_FAST_CHARGE);

        if (isSupported(TOUCHKEY_NOTIFICATION_FILE)) {
            mNotification.setChecked(PREF_ENABLED.equals(Utils.readOneLine(TOUCHKEY_NOTIFICATION_FILE)));
        } else {
            mNotification.setEnabled(false);
        }

        if (isSupported(FAST_CHARGE_FILE)) {
            mFastcharge.setChecked(PREF_ENABLED.equals(Utils.readOneLine(FAST_CHARGE_FILE)));
        } else {
            mFastcharge.setEnabled(false);
        }

        mVibration = (VibrationPreference) findPreference(DeviceSettings.KEY_VIBRATION);
        mVibration.setEnabled(VibrationPreference.isSupported());

    }

    @Override
    public boolean onPreferenceTreeClick(PreferenceScreen preferenceScreen, Preference preference) {

        String boxValue;
        String key = preference.getKey();

        Log.w(TAG, "key: " + key);
        if (key.equals(DeviceSettings.KEY_NOTIFICATION)) {
            final CheckBoxPreference chkPref = (CheckBoxPreference) preference;
            boxValue = chkPref.isChecked() ? "1" : "0";
            Utils.writeValue(TOUCHKEY_NOTIFICATION_FILE, boxValue);
        } else if (key.equals(DeviceSettings.KEY_FAST_CHARGE)) {
            final CheckBoxPreference chkPref = (CheckBoxPreference) preference;
            boxValue = chkPref.isChecked() ? "1" : "0";
            Utils.writeValue(FAST_CHARGE_FILE, boxValue);
            SharedPreferences sharedPrefs = PreferenceManager.getDefaultSharedPreferences(getActivity());
            sharedPrefs.edit().putBoolean(DeviceSettings.KEY_FAST_CHARGE, chkPref.isChecked()).apply();
        }

        return true;
    }

    public static boolean isSupported(String FILE) {
        return Utils.fileExists(FILE);
    }

    public static void restore(Context context) {
        SharedPreferences sharedPrefs = PreferenceManager.getDefaultSharedPreferences(context);
        if (isSupported(TOUCHKEY_NOTIFICATION_FILE)) {
            String sDefaultValue = Utils.readOneLine(TOUCHKEY_NOTIFICATION_FILE);
            Utils.writeValue(TOUCHKEY_NOTIFICATION_FILE, sharedPrefs.getBoolean(DeviceSettings.KEY_NOTIFICATION,
                             PREF_ENABLED.equals(sDefaultValue)));
        }
        if (isSupported(FAST_CHARGE_FILE)) {
            String sDefaultValue = Utils.readOneLine(FAST_CHARGE_FILE);
            Utils.writeValue(FAST_CHARGE_FILE, sharedPrefs.getBoolean(DeviceSettings.KEY_FAST_CHARGE,
                             PREF_ENABLED.equals(sDefaultValue)));
        }
    }
}
