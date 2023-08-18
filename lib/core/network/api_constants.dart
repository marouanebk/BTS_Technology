class ApiConstance {
  // static const String baseUrl = "http://10.0.2.2:5000";
  static const String baseUrl = "https://voy-pro.onrender.com";

  static const String apiKey = "c3435cfe40aeb079689227d82bf921d3";

  static const String authApi = "/api/auth";
  static const String accountApi = "/api/account";
  static const String commandApi = "/api/command";
  static const String financeApi = "/api/finance";

  static const String signup = "$baseUrl$authApi/signup";
  static const String login = "$baseUrl$authApi/login";

  static const String getAllUsers = "$baseUrl$accountApi/get";
  static String getUser  = '$baseUrl$accountApi/getone';

  static const String getAllPages = "$baseUrl/api/page/";
  static const String getAllLivreurs = "$baseUrl/api/livreur/";
  static const String createPage = "$baseUrl/api/page/add";
  static const String createLivreur = "$baseUrl/api/livreur/add";

  static const String getLivreurSold = "$baseUrl/api/livreur/get";
  static const String getAdminUserStats =
      "$baseUrl/api/command/pageadmin/stats";

  static String deletePage(String id) => '$baseUrl/api/page/delete/$id';
  static String deleteLivreur(String id) => '$baseUrl/api/livreur/delete/$id';
  static String deleteUser(String id) => '$baseUrl$accountApi/delete/$id';

  static String editUser(String id) => '$baseUrl$accountApi/update/$id';

  static const String getEntrepriseApi = "$baseUrl/api/entreprise/";
  static const String updateEntrepriseApi = "$baseUrl/api/entreprise/update";

  static const String articleApi = "/api/article";
  static const String getArticles = "$baseUrl$articleApi/get";
  static const String createArticle = "$baseUrl$articleApi/create";
  static String editArticle(String id) => '$baseUrl$articleApi/update/$id';
  static String deleteArticle(String id) => '$baseUrl$articleApi/delete/$id';

  static const String getCommandes = "$baseUrl$commandApi/get";
  static const String createCommandes = "$baseUrl$commandApi/create";
  // static const String updateCommandStatus = "$baseUrl$commandApi/create";
  static const String editCommand = "$baseUrl$commandApi/create";
  static String updateCommand(String id) => '$baseUrl$commandApi/update/$id';
  static String updateCommandStatus(String id) =>
      '$baseUrl$commandApi/status/update/$id';

  static String soutraitanceCommand(String id) =>
      '$baseUrl$commandApi/sous-traitance/$id';

  static const String getCommandesStatsForAdmin =
      "$baseUrl$commandApi/status/stats";

  //finances
  static const String getFinancesApi = "$baseUrl$financeApi/";
  static const String getCashFlowApi = "$baseUrl$financeApi/cashflow";
  static const String createFinanceChargeApi = "$baseUrl$financeApi/add";
  static const String getFinancesChart = "$baseUrl$financeApi/chart";

  static const String getNotificaitonsApi = "$baseUrl/api/notification/";




  //excel 
    static const String getCommandsExcel = "$baseUrl$commandApi/excel";
    static const String getLogsExcel = "$baseUrl$articleApi/excel";
    static const String getFinancesExcel= "$baseUrl$financeApi/excel";


}
