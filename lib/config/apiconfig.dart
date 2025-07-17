class ApiConfig {
  static String base_url = 'URL';
  static String login = '$base_url/api/v1/login';
  static String supplierListing = '$base_url/api/v1/clients/suppliers';
  static String clientListing = '$base_url/api/v1/users/clients';
  static String goldClientData = '$base_url/api/v1/golds?client_id=';
  static String createGoldApi = '$base_url/api/v1/golds';
  static String updateGoldApi = '$base_url/api/v1/golds/';
  static String downloadGoldData = '$base_url/api/v1/clients/';
}
