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
	git submodule update --init
	git submodule update --recursive --remote
	$(FLUTTER) pub get
	$(FLUTTER) pub run build_runner build --delete-conflicting-outputs

	
.PHONY: build-apk
build-apk:
	bash scripts/appendGitEnvs.sh
	$(FLUTTER) pub get
	$(FLUTTER) pub run build_runner build --delete-conflicting-outputs
	$(FLUTTER) build apk -t lib/main.uat.dart

.PHONY: release-apk
release-apk:
	bash scripts/appendGitEnvs.sh
	$(FLUTTER) pub get
	$(FLUTTER) pub run build_runner build --delete-conflicting-outputs
	$(FLUTTER) build appbundle -t lib/main.dart --release -v

.PHONY: build-ipa
build-ipa:
	$(FLUTTER) pub get
	$(FLUTTER) pub run build_runner build --delete-conflicting-outputs
	cd ios && pod install --repo-update && cd ..
	$(FLUTTER) build ipa --release --export-method=ad-hoc

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