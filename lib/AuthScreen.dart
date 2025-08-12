import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart'; // Import DashboardScreen for navigation to the dashboard
import 'SignUpScreen.dart'; // Import SignUpScreen for navigation to the sign-up screen

// M (Model) - Data and business logic
// This section contains the data structures, state management, and business logic.
// - FirebaseAuth instance for handling authentication operations.
// - TextEditingControllers for managing email and password input fields.
// - Validation and authentication logic for user sign-in.
class AuthModel {
  /// Instance of FirebaseAuth for handling authentication operations.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Controller for the email input field.
  final TextEditingController _emailController = TextEditingController();

  /// Controller for the password input field.
  final TextEditingController _passwordController = TextEditingController();

  /// Signs in a user with the provided email and password.
  ///
  /// Validates the email and password, attempts to sign in using FirebaseAuth,
  /// and calls the appropriate callback based on the result.
  ///
  /// [email] The user's email address.
  /// [password] The user's password.
  /// [onSuccess] Callback function to execute on successful sign-in.
  /// [onError] Callback function to execute on error, with an error message.
  Future<void> signIn(String email, String password, Function onSuccess, Function(String) onError) async {
    try {
      // Validate email format using a regular expression
      final emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+');
      if (!emailPattern.hasMatch(email.trim())) {
        onError('Please enter a valid email');
        return;
      }
      // Validate password length
      if (password.trim().length < 6) {
        onError('Password must be at least 6 characters');
        return;
      }

      // Attempt to sign in with FirebaseAuth
      await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      onSuccess();
    } on FirebaseAuthException {
      // Handle Firebase-specific authentication errors
      onError('Sign-in failed: Email or password is incorrect');
    } catch (e) {
      // Handle other unexpected errors
      onError('Sign-in failed: ${e.toString()}');
    }
  }

  /// Disposes of the text controllers to free resources.
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }
}

// C (Controller) - Interaction logic between Model and View
// This section handles the interaction logic, including navigation, animation control, and state updates.
// - Manages AnimationController for background animations.
// - Provides navigation methods for dashboard and sign-up screens.
// - Handles sign-in event and delegates to the model.
class AuthController {
  /// Animation controller for managing background animations.
  late AnimationController _controller;

  /// Animation for the plane icon movement.
  late Animation<double> _planeAnimation;

  /// Animation for the first cloud's movement.
  late Animation<double> _cloudAnimation1;

  /// Animation for the second cloud's movement.
  late Animation<double> _cloudAnimation2;

  /// Animation for the third cloud's movement.
  late Animation<double> _cloudAnimation3;

  /// Animation for the umbrella icon rotation.
  late Animation<double> _umbrellaAnimation;

  /// Animation for the pyramid icon (currently static).
  late Animation<double> _pyramidAnimation;

  /// Instance of AuthModel for handling authentication logic.
  final AuthModel _model = AuthModel();

  /// Build context for navigation and UI interactions.
  final BuildContext context;

  /// Ticker provider for animations.
  final SingleTickerProviderStateMixin<AuthScreen> vsync;

  /// Creates an AuthController with the given context and vsync.
  ///
  /// Initializes the animation controller and animation sequences.
  ///
  /// [context] The build context for navigation and UI interactions.
  /// [vsync] The ticker provider for animation synchronization.
  AuthController(this.context, this.vsync) {
    // Initialize animation controller with a 10-second duration
    _controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: vsync,
    )..repeat();

    // Define animation for plane movement across the screen
    _planeAnimation = Tween<double>(begin: -100, end: 500).animate(
        CurvedAnimation(parent: _controller, curve: Curves.linear));
    // Define animations for cloud movements
    _cloudAnimation1 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _cloudAnimation2 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _cloudAnimation3 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    // Define animation for umbrella rotation
    _umbrellaAnimation = Tween<double>(begin: -0.1, end: 0.1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    // Define static animation for pyramid (no movement)
    _pyramidAnimation = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  /// Disposes of the animation controller and model resources.
  void dispose() {
    _controller.dispose();
    _model.dispose();
  }

  /// Navigates to the DashboardScreen with a scale transition.
  void navigateToDashboard() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => DashboardScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Apply scale transition for navigation
          return ScaleTransition(
            scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 500),
      ),
    );
  }

  /// Navigates to the SignUpScreen.
  void navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  /// Initiates the sign-in process using the model.
  ///
  /// Retrieves email and password from the model and handles the authentication result.
  void signIn() {
    _model.signIn(
      _model._emailController.text,
      _model._passwordController.text,
      navigateToDashboard,
          (errorMessage) {
        // Display error message in a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }
}

// V (View) - UI representation
// This section defines the UI components and layout.
// - Scaffold with a gradient background for visual appeal.
// - Stack for layering background decorations and the authentication card.
// - AnimatedBuilder for dynamic background animations.
// - Authentication card with form inputs and navigation options.
class AuthScreen extends StatefulWidget {
  /// Creates the authentication screen widget.
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin<AuthScreen> {
  /// Controller for handling interactions and animations.
  late AuthController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with context and vsync
    _controller = AuthController(context, this);
  }

  @override
  void dispose() {
    // Dispose of controller resources
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build the main UI with a gradient background
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF007E95),
              Color(0xFF004D65),
              Color(0xFF003653),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            _buildBackgroundDecorations(),
            // Positioned title at the top
            Positioned(
              top: 80,
              left: MediaQuery.of(context).size.width / 2 - 60,
              child: Text(
                "Tourify",
                style: GoogleFonts.poppins(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // Centered authentication card
            Center(child: _buildAuthCard()),
          ],
        ),
      ),
    );
  }

  /// Builds the background decorations with animated icons.
  Widget _buildBackgroundDecorations() {
    return Stack(
      children: [
        // Animated plane icon
        AnimatedBuilder(
          animation: _controller._planeAnimation,
          builder: (context, child) {
            return Positioned(
              top: 60,
              left: _controller._planeAnimation.value,
              child: Icon(
                Icons.flight,
                size: 80,
                color: Colors.white.withOpacity(0.7),
              ),
            );
          },
        ),
        // Animated first cloud
        AnimatedBuilder(
          animation: _controller._cloudAnimation1,
          builder: (context, child) {
            return Positioned(
              top: 100,
              left: 50 + (_controller._cloudAnimation1.value * 50),
              child: Icon(
                Icons.cloud,
                size: 60,
                color: Colors.white.withOpacity(0.6),
              ),
            );
          },
        ),
        // Animated second cloud
        AnimatedBuilder(
          animation: _controller._cloudAnimation2,
          builder: (context, child) {
            return Positioned(
              top: 150,
              left: 200 + (_controller._cloudAnimation2.value * 50),
              child: Icon(
                Icons.cloud,
                size: 70,
                color: Colors.white.withOpacity(0.5),
              ),
            );
          },
        ),
        // Animated third cloud
        AnimatedBuilder(
          animation: _controller._cloudAnimation3,
          builder: (context, child) {
            return Positioned(
              top: 50,
              left: 300 + (_controller._cloudAnimation3.value * 50),
              child: Icon(
                Icons.cloud,
                size: 50,
                color: Colors.white.withOpacity(0.4),
              ),
            );
          },
        ),
        // Animated umbrella icon with rotation
        AnimatedBuilder(
          animation: _controller._umbrellaAnimation,
          builder: (context, child) {
            return Positioned(
              bottom: 100,
              right: 40,
              child: Transform.rotate(
                angle: _controller._umbrellaAnimation.value,
                child: Icon(
                  Icons.beach_access,
                  size: 100,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            );
          },
        ),
        // Static pyramid icon
        AnimatedBuilder(
          animation: _controller._pyramidAnimation,
          builder: (context, child) {
            return Positioned(
              bottom: 50,
              left: 20,
              child: Icon(
                Icons.landscape,
                size: 80,
                color: Colors.white.withOpacity(0.6),
              ),
            );
          },
        ),
      ],
    );
  }

  /// Builds the authentication card with form and navigation options.
  Widget _buildAuthCard() {
    return Container(
      width: 350,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, spreadRadius: 2)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Welcome text
          Text(
            "Welcome Back!",
            style: GoogleFonts.poppins(fontSize: 18, color: Colors.black54),
          ),
          SizedBox(height: 20),
          _buildAuthForm(),
          SizedBox(height: 10),
          // Sign-up navigation link
          GestureDetector(
            onTap: _controller.navigateToSignUp,
            child: Text(
              "Don't have an account? Sign up",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Color(0xFF003653),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the authentication form with email and password fields and login button.
  Widget _buildAuthForm() {
    return Column(
      children: [
        // Email input field
        _buildInputField(Icons.email, "Email"),
        // Password input field
        _buildInputField(Icons.lock, "Password", isPassword: true),
        SizedBox(height: 10),
        // Login button
        GestureDetector(
          onTap: _controller.signIn,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Color(0xFF003653),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Text(
                "Login",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds a text input field for email or password.
  ///
  /// [icon] The icon to display in the input field.
  /// [hint] The hint text for the input field.
  /// [isPassword] Whether the input field is for a password (obscures text).
  Widget _buildInputField(IconData icon, String hint, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: hint == "Email" ? _controller._model._emailController : _controller._model._passwordController,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Color(0xFF003653)),
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}