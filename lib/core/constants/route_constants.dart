class RouteConstants {
  // Main routes
  static const String home = '/';
  static const String tasks = '/tasks';
  static const String journal = '/journal';
  static const String mindfulness = '/mindfulness';
  static const String profile = '/profile';

  // Auth routes
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Task routes
  static const String taskDetails = '/tasks/:id';
  static const String addTask = '/tasks/add';
  static const String editTask = '/tasks/edit/:id';

  // Journal routes
  static const String journalDetails = '/journal/:id';
  static const String addJournalEntry = '/journal/add';
  static const String editJournalEntry = '/journal/edit/:id';

  // Mindfulness routes
  static const String mindfulnessDetails = '/mindfulness/:id';
  static const String addMindfulnessSession = '/mindfulness/add';
  static const String editMindfulnessSession = '/mindfulness/edit/:id';
}
