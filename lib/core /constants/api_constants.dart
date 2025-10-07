class ApiConstants {
  static const String baseUrl = "https://isadora-eupneic-kaden.ngrok-free.dev";

  //! Auth
  static const String register = "/api/auth/register";
  static const String login = "/api/auth/login";

  //! Users

  static String userPosts(String id) => "/api/users/$id/posts";
  static String userApprovedPosts(int id) =>
      '/api/posts/user/$id/status/Approved';
  static String userDeclinededPosts(int id) =>
      '/api/posts/user/$id/status/disapproved';
  static String userPendingPosts(int id) =>
      '/api/posts/user/$id/status/pending';
  static String userProfile(int id) => '/api/users/$id';
  static String becomeModerator(int id) =>
      '/api/moderator-requests/request/$id';

  //! Posts
  static const String createPost = "/api/posts";
  static const String getAllPosts = "/api/posts/approved";
  static String updatePost(int id) => "/api/posts/$id";
  static String deletePost(int id) => "/api/posts/$id";

  //! Comments
  static String sendComment() => "/api/comments";

  //! Moderator

  static String getModeratorPendingPosts() => '/api/moderation/posts';
  static String approvePost(int postId) => '/api/moderation/posts/$postId';
  static String rejectPost(int postId) => '/api/moderation/posts/$postId';
  static String approveComment(int postId) =>
      '/api/moderation/comments/$postId';
  static String rejectComment(int postId) => '/api/moderation/comments/$postId';

  //! Admin
  static String approveModerator(int reqId) =>
      "/api/moderator-requests/$reqId/review"; //used
  static String rejectModerator(int reqId) =>
      "/api/moderator-requests/$reqId/review"; //used
  static String getModeratorRequests = "/api/moderator-requests"; //used

  //! superadmin
  static String getAdminRequests = "api/admin/admin-requests";
  static String approveAdmin(int reqId) =>
      "/api/moderator-requests/$reqId/review"; 
  static String rejectAdmin(int reqId) =>
      "/api/moderator-requests/$reqId/review"; 
}
