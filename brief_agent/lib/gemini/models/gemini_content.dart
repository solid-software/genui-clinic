import 'package:genkit/genkit.dart';

/// One turn of a Gemini conversation: who said it and what.
class const GeminiContent._(
  /// `user` or `model`.
  final String role,

  /// The turn's text.
  final String text,
) {
  static const _user = 'user';
  static const _model = 'model';

  /// A turn from the agent, on the doctor's behalf.
  const GeminiContent.user(String text) : this._(_user, text);

  /// A turn the model wrote.
  const GeminiContent.model(String text) : this._(_model, text);

  /// The turn as a Genkit message.
  Message toMessage() => .new(
    role: .new(role),
    content: [TextPart(text: text)],
  );
}
