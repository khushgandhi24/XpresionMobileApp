enum ManifestFilter {
  awb("AWB No."),
  cd("CD No."),
  date("Manifest Date"),
  mnum("Manifest No.");

  final String name;
  const ManifestFilter(this.name);
}
