/// A single sign-on provider the backend offers, e.g. Microsoft or Google.
class SsoProvider {
  final String id;
  final String name;

  const SsoProvider({required this.id, required this.name});

  factory SsoProvider.fromJson(Map<String, dynamic> json) =>
      SsoProvider(id: json['id'], name: json['name']);
}
