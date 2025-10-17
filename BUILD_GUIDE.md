# 열다(Yeolda) - 빌드 & 배포 가이드

## 📦 빌드 파일 정보

### 생성된 파일
- **APK**: `build/app/outputs/flutter-apk/app-release.apk` (63MB)
  - 원스토어 업로드용
  - 직접 설치 가능
  
- **AAB**: `build/app/outputs/bundle/release/app-release.aab` (51MB)
  - 구글 플레이스토어 필수 형식
  - 원스토어에서도 지원

### 앱 정보
- **패키지명**: com.openlabs.yeolda
- **버전**: 1.0.0 (빌드 1)
- **최소 SDK**: Android API 21 (Android 5.0)
- **타겟 SDK**: Android API 35 (Android 15)

## 🔐 서명 키 정보

### Keystore
- **위치**: `~/yeolda-release-key.jks`
- **별칭**: yeolda-key-alias
- **유효기간**: 10,000일 (~27년)
- **알고리즘**: RSA 2048-bit

⚠️ **중요**: 
- `yeolda-release-key.jks` 파일을 **안전한 곳에 백업**하세요!
- 키를 분실하면 앱 업데이트가 불가능합니다
- 비밀번호: yeolda2025

## 🏗️ 빌드 방법

### APK 빌드 (원스토어용)
```bash
flutter build apk --release
```

### AAB 빌드 (플레이스토어용)
```bash
flutter build appbundle --release
```

### Split APK 빌드 (용량 최적화)
```bash
flutter build apk --release --split-per-abi
```
이렇게 하면 각 CPU 아키텍처별로 APK가 생성됩니다:
- `app-armeabi-v7a-release.apk` (32-bit ARM)
- `app-arm64-v8a-release.apk` (64-bit ARM)
- `app-x86_64-release.apk` (64-bit x86)

## 📱 원스토어 배포

### 1. 원스토어 개발자 센터
- URL: https://dev.onestore.co.kr/
- 계정 생성 및 개발자 등록

### 2. 앱 등록
1. "앱 등록" 클릭
2. 앱 정보 입력:
   - 앱 이름: 열다 (Yeolda)
   - 패키지명: com.openlabs.yeolda
   - 카테고리: 도구/생산성
3. APK 업로드: `app-release.apk`
4. 스크린샷 및 설명 추가
5. 심사 제출

### 3. 필수 항목
- 개인정보처리방침 URL
- 앱 아이콘 (512x512)
- 스크린샷 (최소 2장)
- 앱 설명 (한글)
- 연락처 정보

## 🎮 구글 플레이스토어 배포

### 1. Google Play Console
- URL: https://play.google.com/console/
- 계정 생성 및 등록비 결제 ($25, 평생)

### 2. 앱 만들기
1. "앱 만들기" 클릭
2. 앱 세부정보 입력
3. AAB 업로드: `app-release.aab`
4. 스토어 등록정보 작성
5. 콘텐츠 등급 설정
6. 타겟 국가 및 기기 선택
7. 심사 제출

### 3. 필수 준비사항
- 개인정보처리방침 URL
- 앱 아이콘 (512x512, PNG)
- 기능 그래픽 (1024x500)
- 스크린샷 (최소 2장, 권장 8장)
- 짧은 설명 (80자)
- 전체 설명 (4000자)

## 🔄 업데이트 배포

### 버전 업그레이드
1. `pubspec.yaml`에서 버전 수정:
```yaml
version: 1.0.1+2  # 버전명+빌드번호
```

2. 변경사항 반영:
```bash
flutter clean
flutter pub get
```

3. 빌드:
```bash
flutter build apk --release
flutter build appbundle --release
```

4. 각 스토어에 업로드

### 버전 관리 규칙
- **Major.Minor.Patch+BuildNumber**
- Major: 대규모 변경
- Minor: 기능 추가
- Patch: 버그 수정
- BuildNumber: 매 빌드마다 증가

## 🐛 디버그 빌드

### 개발용 APK
```bash
flutter build apk --debug
```

### 프로파일링용 APK
```bash
flutter build apk --profile
```

## 📊 빌드 크기 분석

### APK 분석
```bash
flutter build apk --release --analyze-size
```

### AAB 분석
```bash
flutter build appbundle --release --analyze-size
```

## ✅ 체크리스트

### 배포 전 확인사항
- [ ] 모든 기능 테스트 완료
- [ ] 프로덕션 API 키 설정
- [ ] 디버그 로그 제거 확인
- [ ] 앱 아이콘 확인
- [ ] 스플래시 스크린 확인
- [ ] 알림 권한 요청 테스트
- [ ] 다양한 기기에서 테스트
- [ ] 버전 정보 업데이트
- [ ] 스토어 등록정보 작성
- [ ] 스크린샷 준비
- [ ] 개인정보처리방침 준비

### 배포 후 모니터링
- [ ] 크래시 보고서 확인
- [ ] 사용자 리뷰 모니터링
- [ ] 성능 메트릭 확인
- [ ] 업데이트 계획 수립

## 🔧 트러블슈팅

### 빌드 실패 시
```bash
# 캐시 정리
flutter clean
rm -rf ~/.gradle/caches/

# 의존성 재설치
flutter pub get

# 다시 빌드
flutter build apk --release
```

### 서명 오류 시
- `key.properties` 파일 경로 확인
- keystore 파일 존재 여부 확인
- 비밀번호 확인

## 📝 참고사항

### 코드 난독화 (ProGuard)
현재는 비활성화되어 있습니다. 활성화하려면 `build.gradle.kts`에서:
```kotlin
isMinifyEnabled = true
isShrinkResources = true
```

### 멀티 APK
다양한 기기에 최적화된 APK를 생성하려면:
```bash
flutter build apk --release --split-per-abi
```

## 🆘 도움말

- Flutter 공식 문서: https://docs.flutter.dev/deployment/android
- 원스토어 개발자 가이드: https://dev.onestore.co.kr/devpoc/guide/guidelist
- Google Play Console 도움말: https://support.google.com/googleplay/android-developer

---

**마지막 업데이트**: 2025-10-17
**빌드 버전**: 1.0.0+1
