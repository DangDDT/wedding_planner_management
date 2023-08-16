enum Environment {
  dev,
  staging,
  prod;

  bool get isDev => this == Environment.dev;

  bool get isStaging => this == Environment.staging;

  bool get isProd => this == Environment.prod;
}
