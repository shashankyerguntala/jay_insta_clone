class ApiConstants {
  static const String baseUrl = "http://localhost:8080";

  //! Auth
  static const String register = "/api/users/signup";
  static const String login = "/api/auth/login";

  //! Users
  static String getProfile(String id) => "/api/users/$id";
  static String deleteUser(String id) => "/api/users/$id";
  static String userPosts(String id) => "/api/users/$id/posts";
  static String userApprovedPosts(String id) =>
      '/api/users/{id}/posts/approved';
  static String userDeclinededPosts(String id) =>
      '/api/users/{id}/posts/declined';
  static String userPendingPosts(String id) => '/api/users/{id}/posts/pending';
  static String userProfile(String id) => '/profile';

  //! Posts
  static const String createPost = "/api/posts";
  static const String getPosts = "/api/posts";
  static String updatePost(String id) => "/api/posts/$id";
  static String deletePost(String id) => "/api/posts/$id";

  //! Comments
  static String createComment(String postId) => "/api/posts/$postId/comments";
  static String getComments(String postId) => "/api/posts/$postId/comments";

  //! Moderator
  static String reviewPost(String postId) => "/api/review/posts/$postId";
  static String reviewComment(String commentId) =>
      "/api/review/comments/$commentId";
  static const String applyModerator = "/api/moderator/request";
  static String approveModerator(String requestId) =>
      "/api/moderator/$requestId";

  //! Admin
  static const String requestAdmin = "/api/admins/request";
  static String approveAdmin(String requestId) => "/api/admins/$requestId";
}
