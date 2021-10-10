import 'dart:convert';
import 'dart:io';
import 'package:chat/layouts/layout_cubit/social_states.dart';
import 'package:chat/models/messages_model.dart';
import 'package:chat/models/post_model.dart';
import 'package:chat/models/social_user_model.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/screens/chats/social_chats.dart';
import 'package:chat/screens/home/social_home.dart';
import 'package:chat/screens/post/create_post.dart';
import 'package:chat/screens/settings/social_settings.dart';
import 'package:chat/screens/users/social_users.dart';
import 'package:chat/shared/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(InitialSocialStates());

  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

  void getUsers() {
    emit(LoadingGetUserSocialStates());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(json: value.data());
      emit(SuccessGetUserSocialStates());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetUserSocialStates());
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    SocialHomeScreen(),
    SocialChatsScreen(),
    SocialCreatePostScreen(),
    SocialUsersScreen(),
    SocialSettingsScreen()
  ];

  List<String> titles = ["Home", "Chats", "Post", "Users", "Settings"];

  void changeBetweenScreens(int index) {
    if (index == 2) {
      emit(CreatePostBottomNavigationBar());
    } else {
      currentIndex = index;
      emit(ChangeCurrentIndexOfBottomNavigationBar());
    }
  }

  var picker = ImagePicker();
  File? profileImage;

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SuccessPickedProfileImageSuccess());
    } else {
      print("No Image is Selected");
      emit(ErrorPickedProfileImageSuccess());
    }
  }

  File? coverImage;

  Future getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SuccessPickedCoverImageSuccess());
    } else {
      print("No Image is Selected");
      emit(ErrorPickedCoverImageSuccess());
    }
  }

  void uploadProfileImage(
      {required String username,
      required String bio,
      required String phone,
      String? image,
      String? cover}) {
    emit(LoadingUploadProfileImage());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SuccessUploadAndGetURLProfileImage());
        updateUserData(
            username: username, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        print(onError.toString());
        emit(ErrorUploadProfileImage());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorUploadProfileImage());
    });
  }

  void uploadCoverImage(
      {required String username,
      required String bio,
      required String phone,
      String? image,
      String? cover}) {
    emit(LoadingUploadCoverImage());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SuccessUploadAndGetURLCoverImage());
        updateUserData(
            username: username, phone: phone, bio: bio, cover: value);
      }).catchError((error) {});
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorUploadCoverImage());
    });
  }

  void updateUserData(
      {required String username,
      required String bio,
      required String phone,
      String? image,
      String? cover}) {
    emit(LoadingUpdateUserData());
    UserModel userUpdate = UserModel(
        username: username,
        email: userModel!.email,
        cover: cover ?? userModel!.cover,
        uId: userModel!.uId,
        bio: bio,
        phone: phone,
        image: image ?? userModel!.image);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(userUpdate.toMap())
        .then((value) {
      getUsers();
      emit(SuccessUpdateUserData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUpdateUserData());
    });
  }

  //posts
  File? postImage;

  Future getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SuccessPickedCreatePostImage());
    } else {
      print("No Image is Selected");
      emit(ErrorPickedCreatePostImage());
    }
  }

  void uploadPostWithImage({required String text, required String datetime}) {
    emit(LoadingUploadPostWithImage());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(text: text, datetime: datetime, postImage: value);
      }).catchError((error) {
        print(onError.toString());
        emit(ErrorUploadPostWithImage());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorUploadPostWithImage());
    });
  }

  void createPost(
      {required String text, required String datetime, String? postImage}) {
    PostModel model = PostModel(
        username: userModel!.username,
        image: userModel!.image,
        uId: userModel!.uId,
        dateTime: datetime,
        text: text,
        postImage: postImage ?? "");
    emit(LoadingCreatePost());
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SuccessCreatePost());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorCreatePost());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemoveImageFromPost());
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> countLikes = [];

  void getAllPosts() {
    FirebaseFirestore.instance.collection("posts").get().then((value) {
      for (var element in value.docs) {
        element.reference.collection("likes").get().then((value) {
          countLikes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(json: element.data()));
        }).catchError((error) {
          print(error.toString());
        });
        emit(SuccessGetAllPostsSocialStates());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetAllPostsSocialStates());
    });
  }

  bool isLiked = false;

  void likePosts(String postId) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(userModel!.uId)
        .set({'likes': true}).then((value) {
      isLiked = !isLiked;
      emit(SuccessLikesPostsSocialStates());
    }).catchError((error) {
      emit(ErrorLikesPostsSocialStates());
    });
  }

  List<UserModel> getAllUser = [];

  void getAllUsers() {
    getAllUser = [];
    FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != uId) {
          getAllUser.add(UserModel.fromJson(json: element.data()));
        }
      });
      emit(SuccessGetUsersForChatsSocialStates());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetUsersForChatsSocialStates());
    });
  }

  void sendMessages(
      { required String message,
        required String dateTime,
      required String receiverId,
      }) {
    MessagesModel messagesModel = MessagesModel(
        message: message,
        dataTime: dateTime,
        senderId: userModel!.uId,
        receiverId: receiverId,
       );
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .add(messagesModel.toMap())
        .then((value) {
      emit(SuccessSendMessagesState());
    }).catchError((error) {
      emit(ErrorSendMessagesState());
    });

    FirebaseFirestore.instance
        .collection("users")
        .doc(receiverId)
        .collection("chats")
        .doc(uId)
        .collection("messages")
        .add(messagesModel.toMap())
        .then((value) {
      emit(SuccessSendMessagesState());
    }).catchError((error) {
      emit(ErrorSendMessagesState());
    });
  }

  List<MessagesModel> listOfMessages = [];

  void getAllMessages({required receiverId}) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .orderBy("dataTime")
        .snapshots()
        .listen((event) {
      listOfMessages = [];
      for (var element in event.docs) {
        listOfMessages.add(MessagesModel.fromJson(json: element.data()));
      }
      emit(SuccessGetMessagesState());
    });
  }



}
