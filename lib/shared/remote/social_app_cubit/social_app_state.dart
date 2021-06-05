abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialLoadingState extends SocialStates{}

class SocialSuccessState extends SocialStates{}

class SocialErrorState extends SocialStates
{
  final error;
  SocialErrorState(this.error);
}
class SocialAllUserLoadingState extends SocialStates{}

class SocialAllUserSuccessState extends SocialStates{}

class SocialAllUserErrorState extends SocialStates
{
  final error;
  SocialAllUserErrorState(this.error);
}
//To public Post
class SocialGetPostsLoadingState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}

class SocialGetPostsErrorState extends SocialStates
{
  final error;
  SocialGetPostsErrorState(this.error);
}

class SocialChangeNavigationBarState extends SocialStates{}

class SocialAddPostState extends SocialStates{}

class SocialChangeProfilePhotoSuccessState extends SocialStates{}

class SocialChangeProfilePhotoErrorState extends SocialStates{}

class SocialChangeCoverImageSuccessState extends SocialStates{}

class SocialChangeCoverImageErrorState extends SocialStates{}

class SocialUploadProfilePhotoSuccessState extends SocialStates{}

class SocialUploadProfilePhotoErrorState extends SocialStates{}

class SocialUploadCoverImageSuccessState extends SocialStates{}

class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUploadUserErrorState extends SocialStates{}

class SocialUploadLoadingState extends SocialStates{}

class SocialCreatePostImageLoadingState extends SocialStates{}

//Image To Public
class SocialPostImageSuccessState extends SocialStates{}

class SocialPostImageErrorState extends SocialStates{}

//CreatePostsAnd Remove it

class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}

class SocialRemovePostImageState extends SocialStates{}

//Like Posts

class SocialLikePostSuccessState extends SocialStates{}

class SocialLikePostErrorState extends SocialStates{}

//comments

class SocialCommentsPostSuccessState extends SocialStates{}

class SocialCommentsPostErrorState extends SocialStates {
  final String error;

  SocialCommentsPostErrorState(this.error);
}
  //messenge
  class SocialGetMessageSuccessState extends SocialStates{}

  class SocialGetMessageErrorState extends SocialStates{}

  class SocialSendMessageSuccessState extends SocialStates{}

  class SocialSendMessageErrorState extends SocialStates{}



