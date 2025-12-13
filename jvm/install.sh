echo "Setting up JVM environment..."

GRADLE_VERSION="9.2.1"
JAVA_VERSION="21.0.9-tem"
KOTLIN_VERSION="2.1.21"

if [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
  source "$HOME/.sdkman/bin/sdkman-init.sh"
else
  echo "Installing sdkman..."
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  echo "Installed sdkman: $(sdk version)"
fi

if sdk current gradle | grep -q "$GRADLE_VERSION"; then
  echo "Gradle already installed: $(sdk current gradle)"
else
  echo "Installing Gradle..."
  sdk default gradle "$GRADLE_VERSION" &> /dev/null
  sdk install gradle "$GRADLE_VERSION" &> /dev/null
  sdk default gradle "$GRADLE_VERSION" &> /dev/null
  sdk current gradle
fi

if sdk current java | grep -q "$JAVA_VERSION"; then
  echo "Java already installed: $(sdk current java)"
else
  echo "Installing Java..."
  sdk default java "$JAVA_VERSION" &> /dev/null
  sdk install java "$JAVA_VERSION" &> /dev/null
  sdk default java "$JAVA_VERSION" &> /dev/null
  sdk current java
fi

if sdk current kotlin | grep -q "$KOTLIN_VERSION"; then
  echo "Kotlin already installed: $(sdk current kotlin)"
else
  echo "Installing Kotlin..."
  sdk default kotlin "$KOTLIN_VERSION" &> /dev/null
  sdk install kotlin "$KOTLIN_VERSION" &> /dev/null
  sdk default kotlin "$KOTLIN_VERSION" &> /dev/null
  sdk current kotlin
fi

mkdir -p "$OUTPUT_DIR/.gradle"
op inject -i "jvm/gradle.properties.tpl" -o "$OUTPUT_DIR/.gradle/gradle.properties"
