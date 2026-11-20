import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../app.dart';
import '../models/app_user.dart';
import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';

// Screen 1 · Login. Owner: Mardon.
// Figma: "1. Login — Student", "1b. Login — Professor".

String? validateNewuuEmail(String? value) {
  final email = value?.trim().toLowerCase() ?? '';
  if (email.isEmpty) return 'Enter your university email';
  if (!RegExp(r'^[^@\s]+@newuu\.uz$').hasMatch(email)) {
    return 'Use your @newuu.uz email';
  }
  return null;
}

String? validatePassword(String? value) {
  if ((value ?? '').length < 6) return 'At least 6 characters';
  return null;
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole _role = UserRole.student;
  bool _hidePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    if (!_formKey.currentState!.validate()) return;
    ref
        .read(authProvider.notifier)
        .signIn(email: _emailController.text.trim().toLowerCase(), role: _role);
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(child: _BlueBerryLogo()),
                    const SizedBox(height: 18),
                    Text(
                      'BlueBerry',
                      textAlign: TextAlign.center,
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Room changes, cancellations and deadlines\n'
                      'for your NewUU courses, in one feed.',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 36),
                    const _FieldLabel('I am a'),
                    SegmentedButton<UserRole>(
                      segments: const [
                        ButtonSegment(
                          value: UserRole.student,
                          label: Text('Student'),
                        ),
                        ButtonSegment(
                          value: UserRole.professor,
                          label: Text('Professor'),
                        ),
                      ],
                      selected: {_role},
                      showSelectedIcon: false,
                      onSelectionChanged: (selection) =>
                          setState(() => _role = selection.first),
                    ),
                    const SizedBox(height: 22),
                    const _FieldLabel('University email'),
                    TextFormField(
                      key: const Key('emailField'),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      autofillHints: const [AutofillHints.email],
                      decoration: const InputDecoration(
                        hintText: 'name@newuu.uz',
                      ),
                      validator: validateNewuuEmail,
                    ),
                    const SizedBox(height: 22),
                    const _FieldLabel('Password'),
                    TextFormField(
                      key: const Key('passwordField'),
                      controller: _passwordController,
                      obscureText: _hidePassword,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.password],
                      onFieldSubmitted: (_) => _signIn(),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          tooltip: _hidePassword
                              ? 'Show password'
                              : 'Hide password',
                          color: AppColors.textMuted,
                          icon: Icon(
                            _hidePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () =>
                              setState(() => _hidePassword = !_hidePassword),
                        ),
                      ),
                      validator: validatePassword,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Use your @newuu.uz email · at least 6 characters',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textFaint,
                      ),
                    ),
                    const SizedBox(height: 30),
                    FilledButton(
                      onPressed: _signIn,
                      child: const Text('Sign in'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall
            ?.copyWith(color: AppColors.textMuted, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// App icon from the Figma frame: a blueberry on a dark blue tile.
class _BlueBerryLogo extends StatelessWidget {
  const _BlueBerryLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(22),
      ),
      child: const CustomPaint(painter: _BerryPainter()),
    );
  }
}

class _BerryPainter extends CustomPainter {
  const _BerryPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.53);
    final radius = size.width * 0.2;

    canvas.drawCircle(center, radius, Paint()..color = AppColors.primary);
    canvas.drawCircle(
      center + Offset(-radius * 0.45, -radius * 0.35),
      radius * 0.22,
      Paint()..color = Colors.white.withValues(alpha: 0.25),
    );

    final crown = Path()
      ..moveTo(center.dx - radius * 0.35, center.dy - radius * 1.05)
      ..lineTo(center.dx, center.dy - radius * 0.75)
      ..lineTo(center.dx + radius * 0.35, center.dy - radius * 1.05);
    canvas.drawPath(
      crown,
      Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
