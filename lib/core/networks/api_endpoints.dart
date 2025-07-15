const String baseUrl = 'http://95.217.186.227:4003/api';
const String loginEndpoint = '/auth/login';
const String signUpEndpoint = '/auth/register';
const String logoutEndpoint = '/auth/logout';
const String refreshTokenEndpoint = '/auth/refresh';
const String checkAuthEndpoint = '/user/me';
String commentEndpoint(String newsId) => '/news/comment/$newsId';
