class ApiConstance {
  static const String baseUrl = "http://10.0.2.2:5000";
  static const String apiKey = "c3435cfe40aeb079689227d82bf921d3";
  static const String authApi = "/api/auth";
  static const String signup = "$baseUrl$authApi/signup";
  static const String login = "$baseUrl$authApi/signup";

  static const String messageRoutes = "/api/message";
  static const String conversationRoutes = "/api/conversation";
  static const String groupRoutes = "/api/groupe";

  static String addMessage = "$baseUrl$messageRoutes/addmessage/";
  static String getMessage(String userid) =>
      '$baseUrl$messageRoutes/getallmessag/$userid';

  static String addConversation =
      "$baseUrl$conversationRoutes/addconversation/";

  static String getAllConversations(String userid) =>
      '$baseUrl$conversationRoutes/getconversations/$userid';

  static String addGroup = "$baseUrl$groupRoutes/addgroupe/";
  static String addtogroupe = '$baseUrl$groupRoutes/addtogroupe/';
}
