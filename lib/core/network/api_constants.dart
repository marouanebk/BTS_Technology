class ApiConstance {
  static const String baseUrl = "http://10.0.2.2:5000";
  static const String apiKey = "c3435cfe40aeb079689227d82bf921d3";

  static const String authApi = "/api/auth";
  static const String accountApi = "/api/account";

  static const String signup = "$baseUrl$authApi/signup";
  static const String login = "$baseUrl$authApi/login";

  static const String getAllUsers = "$baseUrl$accountApi/get";
  static const String getAllPages = "$baseUrl/api/page/";
  static const String getAllLivreurs= "$baseUrl/api/livreur/";
  static const String createPage= "$baseUrl/api/page/add";
  static const String createLivreur= "$baseUrl/api/livreur/add";

  static const String articleApi = "/api/article";
  static const String getArticles = "$baseUrl$articleApi/get";
  static const String createArticle = "$baseUrl$articleApi/create";

  // static String addConversation =
  //     "$baseUrl$conversationRoutes/addconversation/";

  // static String getAllConversations(String userid) =>
  //     '$baseUrl$conversationRoutes/getconversations/$userid';

  // static String addGroup = "$baseUrl$groupRoutes/addgroupe/";
  // static String addtogroupe = '$baseUrl$groupRoutes/addtogroupe/';
}
