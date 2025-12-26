# Script to extract SHA fingerprints for Google Sign-In setup

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  SHA Fingerprint Extraction Tool" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Debug Keystore
Write-Host "1. DEBUG KEYSTORE FINGERPRINTS" -ForegroundColor Yellow
Write-Host "   Location: $env:USERPROFILE\.android\debug.keystore" -ForegroundColor Gray
Write-Host ""

try {
    $debugOutput = keytool -list -v -keystore "$env:USERPROFILE\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android 2>&1 | Out-String
    
    if ($debugOutput -match "SHA1:\s*([A-F0-9:]+)") {
        $sha1Debug = $matches[1].Trim()
        Write-Host "   SHA-1:   $sha1Debug" -ForegroundColor Green
    }
    
    if ($debugOutput -match "SHA256:\s*([A-F0-9:]+)") {
        $sha256Debug = $matches[1].Trim()
        Write-Host "   SHA-256: $sha256Debug" -ForegroundColor Green
    }
} catch {
    Write-Host "   Error: Could not read debug keystore" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Release Keystore
Write-Host "2. RELEASE KEYSTORE FINGERPRINTS" -ForegroundColor Yellow
Write-Host "   Location: android\app\gauva.keystore" -ForegroundColor Gray
Write-Host ""

try {
    $releaseOutput = keytool -list -v -keystore "android\app\gauva.keystore" -alias gauva -storepass 1234567890 -keypass 1234567890 2>&1 | Out-String
    
    if ($releaseOutput -match "SHA1:\s*([A-F0-9:]+)") {
        $sha1Release = $matches[1].Trim()
        Write-Host "   SHA-1:   $sha1Release" -ForegroundColor Green
    }
    
    if ($releaseOutput -match "SHA256:\s*([A-F0-9:]+)") {
        $sha256Release = $matches[1].Trim()
        Write-Host "   SHA-256: $sha256Release" -ForegroundColor Green
    }
} catch {
    Write-Host "   Error: Could not read release keystore" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "NEXT STEPS:" -ForegroundColor Cyan
Write-Host "1. Copy the SHA-1 and SHA-256 values above" -ForegroundColor White
Write-Host "2. Go to Firebase Console: https://console.firebase.google.com/" -ForegroundColor White
Write-Host "3. Select project: gauva-15d9a" -ForegroundColor White
Write-Host "4. Go to Project Settings > Your apps > Android app" -ForegroundColor White
Write-Host "5. Add ALL FOUR fingerprints (both debug and release)" -ForegroundColor White
Write-Host "6. Download updated google-services.json" -ForegroundColor White
Write-Host "7. Replace android/app/google-services.json" -ForegroundColor White
Write-Host "8. Run: flutter clean && flutter pub get && flutter run" -ForegroundColor White
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
