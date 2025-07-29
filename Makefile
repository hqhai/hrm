FLUTTER ?=flutter


.PHONY: gen-code
gen-code:
	$(FLUTTER) pub run build_runner build --delete-conflicting-outputs

.PHONY: test
test:
	bash scripts/appendGitEnvs.sh
	git submodule update --init
	git submodule update --recursive --remote
	$(FLUTTER) pub get
	$(FLUTTER) pub run build_runner build --delete-conflicting-outputs
	$(FLUTTER) analyze

.PHONY: clean
clean:
	$(FLUTTER) clean
	pod cache clean  --all
	rm -rf ios/Flutter/Flutter.framework
	make init

.PHONY: init
init:
	bash scripts/appendGitEnvs.sh
	git submodule update --init
	git submodule update --recursive --remote
	fvm use 3.32.5
	fvm flutter pub get
	fvm flutter pub run build_runner build --delete-conflicting-outputs

	
.PHONY: build-apk-uat
build-apk-uat:
	bash scripts/appendGitEnvs.sh
	$(FLUTTER) pub get
	$(FLUTTER) pub run build_runner build --delete-conflicting-outputs
	$(FLUTTER) build apk --flavor uat -t lib/main.uat.dart -v

.PHONY: build-apk-staging
build-apk-staging:
	bash scripts/appendGitEnvs.sh
	$(FLUTTER) pub get
	$(FLUTTER) pub run build_runner build --delete-conflicting-outputs
	$(FLUTTER) build apk --flavor staging -t lib/main.staging.dart --verbose

.PHONY: build-apk-production
build-apk-production:
	bash scripts/appendGitEnvs.sh
	$(FLUTTER) pub get
	$(FLUTTER) pub run build_runner build --delete-conflicting-outputs
	$(FLUTTER) build apk --flavor production --release -v

.PHONY: release-apk
release-apk:
	bash scripts/appendGitEnvs.sh
	fvm use 3.32.5
	fvm flutter pub get
	fvm flutter pub run build_runner build --delete-conflicting-outputs
	fvm flutter build appbundle --flavor production -t lib/main.dart --release -v

.PHONY: build-ipa
build-ipa:
	$(FLUTTER) pub get
	$(FLUTTER) pub run build_runner build --delete-conflicting-outputs
	cd ios && pod install --repo-update && cd ..
	$(FLUTTER) build ipa -t lib/main.dart --release --export-method=ad-hoc -v

.PHONY: build-ipa-uat
build-ipa-uat:
	$(FLUTTER) pub get
	$(FLUTTER) pub run build_runner build --delete-conflicting-outputs
	cd ios && pod install --repo-update && cd ..
	$(FLUTTER) build ipa --flavor uat -t lib/main.uat.dart --release --export-method=ad-hoc -v

.PHONY: build-ipa-staging
build-ipa-staging:
	$(FLUTTER) pub get
	$(FLUTTER) pub run build_runner build --delete-conflicting-outputs
	cd ios && pod install --repo-update && cd ..
	$(FLUTTER) build ipa --flavor staging -t lib/main.staging.dart --release --export-method=ad-hoc -v

.PHONY: git-hook
git-hook:
	# Allow bash script execute
	chmod -R 777 .githooks
	# Authorize system can run all script in scripts folder
	chmod -R 777 scripts
	# Distinct the case sensitive file name
	git config core.ignorecase false
	git config core.hooksPath .githooks
	# Append git env
	bash scripts/appendGitEnvs.sh