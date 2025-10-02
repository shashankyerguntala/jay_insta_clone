class ApiConstants {
  static const String baseUrl = "http://localhost:8080"; 

  //! Auth
  static const String register = "/api/auth/register";
  static const String login = "/api/auth/login";

  //! Users
  static String getProfile(int id) => "/api/users/$id";
  static String deleteUser(int id) => "/api/users/$id";
  static String userPosts(int id) => "/api/users/$id/posts";

  //! Posts
  static const String createPost = "/api/posts";
  static const String getPosts = "/api/posts";
  static String updatePost(int id) => "/api/posts/$id";
  static String deletePost(int id) => "/api/posts/$id";

  //! Comments
  static String createComment(int postId) => "/api/posts/$postId/comments";
  static String getComments(int postId) => "/api/posts/$postId/comments";

  //! Moderator
  static String reviewPost(int postId) => "/api/review/posts/$postId";
  static String reviewComment(int commentId) => "/api/review/comments/$commentId";
  static const String applyModerator = "/api/moderator/request";
  static String approveModerator(int requestId) => "/api/moderator/$requestId";

  //! Admin
  static const String requestAdmin = "/api/admins/request";
  static String approveAdmin(int requestId) => "/api/admins/$requestId";
}
