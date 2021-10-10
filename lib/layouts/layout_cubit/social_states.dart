abstract class SocialStates {}

class InitialSocialStates extends SocialStates {}

class SuccessGetUserSocialStates extends SocialStates {}

class ErrorGetUserSocialStates extends SocialStates {}

class LoadingGetUserSocialStates extends SocialStates {}

class ChangeCurrentIndexOfBottomNavigationBar extends SocialStates {}

class CreatePostBottomNavigationBar extends SocialStates {}

class SuccessPickedProfileImageSuccess extends SocialStates {}

class SuccessPickedCoverImageSuccess extends SocialStates {}

class ErrorPickedProfileImageSuccess extends SocialStates {}

class ErrorPickedCoverImageSuccess extends SocialStates {}

class LoadingUploadProfileImage extends SocialStates {}

class SuccessUploadAndGetURLProfileImage extends SocialStates {}

class ErrorUploadProfileImage extends SocialStates {}

class LoadingUploadCoverImage extends SocialStates {}

class SuccessUploadAndGetURLCoverImage extends SocialStates {}

class ErrorUploadCoverImage extends SocialStates {}

class LoadingUpdateUserData extends SocialStates {}

class SuccessUpdateUserData extends SocialStates {}

class ErrorUpdateUserData extends SocialStates {}

//create post
class LoadingCreatePost extends SocialStates {}

class SuccessCreatePost extends SocialStates {}

class ErrorCreatePost extends SocialStates {}

class SuccessPickedCreatePostImage extends SocialStates {}

class ErrorPickedCreatePostImage extends SocialStates {}

class LoadingUploadPostWithImage extends SocialStates {}

class ErrorUploadPostWithImage extends SocialStates {}

class RemoveImageFromPost extends SocialStates {}

// get posts
class SuccessGetAllPostsSocialStates extends SocialStates {}

class ErrorGetAllPostsSocialStates extends SocialStates {}

//likes posts
class SuccessLikesPostsSocialStates extends SocialStates {}

class ErrorLikesPostsSocialStates extends SocialStates {}

class OnLikeSuccess extends SocialStates {}

//get users

class SuccessGetUsersForChatsSocialStates extends SocialStates {}

class ErrorGetUsersForChatsSocialStates extends SocialStates {}

//messages
class SuccessSendMessagesState extends SocialStates {}

class ErrorSendMessagesState extends SocialStates {}

class SuccessGetMessagesState extends SocialStates {}

class ErrorGetMessagesState extends SocialStates {}

// send image message

class LoadingUploadMessageImage extends SocialStates {}


class ErrorUploadMessageImage extends SocialStates {}

class SuccessPickedMessageImage extends SocialStates {}

class ErrorPickedMessageImage extends SocialStates {}

class RemoveSendMessageImage extends SocialStates {}