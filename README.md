# Aiya App

## Start Development

```
flutter doctor
flutter clean
flutter pub get
flutter packages pub run build_runner watch --delete-conflicting-outputs
```

## Encryption/Decryption

```
algorithm: AES-CBC-PKCS5
FileHeader key: 8EFD40A99E6AAB3BCF042FDBDC97CD22787060657EA38C4545EF3A91E4ED0A3E (256-bit)
FileHeader iv: 466F722046726F646F212540262A4D3B (128-bit)
FileBody key: [given by API, and it's all numbers] (256-bit)
FileBody iv: 57c621a9368701bda374f0b4ab43cd47 (128-bit)
```
