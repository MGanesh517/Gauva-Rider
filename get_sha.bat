@echo off
echo ======================================== > sha_fingerprints.txt
echo   SHA FINGERPRINT EXTRACTION RESULTS >> sha_fingerprints.txt
echo ======================================== >> sha_fingerprints.txt
echo. >> sha_fingerprints.txt

echo 1. DEBUG KEYSTORE FINGERPRINTS >> sha_fingerprints.txt
echo    Location: %USERPROFILE%\.android\debug.keystore >> sha_fingerprints.txt
echo. >> sha_fingerprints.txt

keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android 2>&1 | findstr "SHA1 SHA256" >> sha_fingerprints.txt

echo. >> sha_fingerprints.txt
echo ======================================== >> sha_fingerprints.txt
echo. >> sha_fingerprints.txt

echo 2. RELEASE KEYSTORE FINGERPRINTS >> sha_fingerprints.txt
echo    Location: android\app\gauva.keystore >> sha_fingerprints.txt
echo. >> sha_fingerprints.txt

keytool -list -v -keystore "android\app\gauva.keystore" -alias gauva -storepass 1234567890 -keypass 1234567890 2>&1 | findstr "SHA1 SHA256" >> sha_fingerprints.txt

echo. >> sha_fingerprints.txt
echo ======================================== >> sha_fingerprints.txt
echo. >> sha_fingerprints.txt
echo NEXT STEPS: >> sha_fingerprints.txt
echo 1. Open sha_fingerprints.txt to see your SHA values >> sha_fingerprints.txt
echo 2. Go to Firebase Console: https://console.firebase.google.com/ >> sha_fingerprints.txt
echo 3. Select project: gauva-15d9a >> sha_fingerprints.txt
echo 4. Go to Project Settings ^> Your apps ^> Android app >> sha_fingerprints.txt
echo 5. Add ALL fingerprints (both debug and release) >> sha_fingerprints.txt
echo 6. Download updated google-services.json >> sha_fingerprints.txt
echo 7. Replace android/app/google-services.json >> sha_fingerprints.txt
echo 8. Run: flutter clean ^&^& flutter pub get ^&^& flutter run >> sha_fingerprints.txt
echo. >> sha_fingerprints.txt

echo Fingerprints saved to sha_fingerprints.txt
type sha_fingerprints.txt
