import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference music = FirebaseFirestore.instance.collection('music');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference post = FirebaseFirestore.instance.collection('post');
  CollectionReference community =
      FirebaseFirestore.instance.collection('community');
  CollectionReference comment =
      FirebaseFirestore.instance.collection('comment');
  CollectionReference chat = FirebaseFirestore.instance.collection('chat');

  //create users
  Future<void> createUser(Map<String, dynamic> values) async {
    String id = values['uid'];
    await users.doc(id).set(values);
  }

  //create post
  Future<void> createPost(Map<String, dynamic> values) async {
    String id = values['id'];
    await post.doc(id).set(values);
  }

  //create comment
  Future<void> createComment(Map<String, dynamic> values) async {
    String id = values['id'];
    await comment.doc(id).set(values);
  }

  //create community
  Future<void> createCommunity(Map<String, dynamic> values) async {
    String id = values['name'];

    var communityDoc = await community.doc(id).get();
    if (communityDoc.exists) {
      throw "Community already exists!";
    }

    await community.doc(id).set(values);
  }

  //create r chat
  Future<void> createReceiverChat(Map<String, dynamic> values) async {
    String senderId = values['senderId'];
    String receiverId = values['receiverId'];
    String messageId = values['messageId'];

    await users
        .doc(receiverId)
        .collection('chats')
        .doc(senderId)
        .collection('messages')
        .doc(messageId)
        .set(values);
  }

  //create s chat
  Future<void> createSenderChat(Map<String, dynamic> values) async {
    String senderId = values['senderId'];
    String receiverId = values['receiverId'];
    String messageId = values['messageId'];

    await users
        .doc(senderId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc(messageId)
        .set(values);
  }

  //save message subcollection
  Future<void> saveMessageSub(Map<String, dynamic> values) async {
    String senderId = values['senderId'];
    String receiverId = values['receiverId'];

    await users.doc(senderId).collection('chats').doc(receiverId).set(values);
  }

//add comment count
  Future<void> addCommentCount(id) async {
    DocumentReference postRef = post.doc(id);

    // Use a transaction to ensure atomicity and consistency
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot postSnapshot = await transaction.get(postRef);
      int currentCommentCount = postSnapshot['commentCount'] ?? 0;
      int updatedCommentCount = currentCommentCount + 1;

      // Update the comment count field
      transaction.update(postRef, {'commentCount': updatedCommentCount});
    });
  }

//addtoplaylist
  Future<void> addToPlaylist(String userId, String id) async {
    DocumentReference usersPlayList = users.doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot usersPlayListSnapshot =
          await transaction.get(usersPlayList);
      if (!usersPlayListSnapshot.exists) {
        List<dynamic>? playList = [];
        playList.add(userId);

        transaction.update(usersPlayList, {
          'playList': playList,
        });
      } else {
        List<dynamic>? playList = usersPlayListSnapshot['playList'];
        // check if uid exists
        bool containsUserID = playList!.contains(userId);
        if (containsUserID == true) {
          // ignore
        } else {
          playList.add(userId);
          transaction.update(usersPlayList, {
            'playList': playList,
          });
        }
      }
    });
  }

//remove from playlist
  Future<void> removeFromPlaylist(String userId, String id) async {
    DocumentReference usersPlayList = users.doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot usersPlayListSnapshot =
          await transaction.get(usersPlayList);
      if (!usersPlayListSnapshot.exists) {
        List<dynamic>? playList = [];
        playList.remove(userId);

        transaction.update(usersPlayList, {
          'playList': playList,
        });
      } else {
        List<dynamic>? playList = usersPlayListSnapshot['playList'];
        // check if uid exists
        bool containsUserID = playList!.contains(userId);
        if (containsUserID == true) {
          playList.remove(userId);
          transaction.update(usersPlayList, {
            'playList': playList,
          });
        } else {
          playList.remove(userId);
          transaction.update(usersPlayList, {
            'playList': playList,
          });
        }
      }
    });
  }

//add to playcount
  Future<void> addToPlayCount(String userId, String id) async {
    DocumentReference songsPlayCount = music.doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot songsPlayCountSnapshot =
          await transaction.get(songsPlayCount);
      if (!songsPlayCountSnapshot.exists) {
        List<dynamic>? playCount = [];
        playCount.add(userId);

        transaction.update(songsPlayCount, {
          'playCount': playCount,
        });
      } else {
        List<dynamic>? playCount = songsPlayCountSnapshot['playCount'];
        // check if uid exists
        bool containsUserID = playCount!.contains(userId);
        if (containsUserID == true) {
          // ignore
        } else {
          playCount.add(userId);
          transaction.update(songsPlayCount, {
            'playCount': playCount,
          });
        }
      }
    });
  }

//remove from play count
  Future<void> removeFromPlayCount(String userId, String id) async {
    DocumentReference songsPlayCount = music.doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot songsPlayCountSnapshot =
          await transaction.get(songsPlayCount);
      if (!songsPlayCountSnapshot.exists) {
        List<dynamic>? playCount = [];
        playCount.remove(userId);

        transaction.update(songsPlayCount, {
          'playCount': playCount,
        });
      } else {
        List<dynamic>? playCount = songsPlayCountSnapshot['playCount'];
        // check if uid exists
        bool containsUserID = playCount!.contains(userId);
        if (containsUserID == true) {
          playCount.remove(userId);
          transaction.update(songsPlayCount, {
            'playCount': playCount,
          });
        } else {
          playCount.remove(userId);
          transaction.update(songsPlayCount, {
            'playCount': playCount,
          });
        }
      }
    });
  }

//add music ids
  Future<void> addMusicIds() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('music').get();

    final WriteBatch batch = FirebaseFirestore.instance.batch();

    for (final DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      final String docId = documentSnapshot.id;
      batch.update(FirebaseFirestore.instance.collection('music').doc(docId),
          {'musicUid': docId});
    }

    await batch.commit();
  }

//join community
  Future<void> joinCommunity(String userId, String id) async {
    DocumentReference joinCommunity = community.doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot joinCommunitySnapshot =
          await transaction.get(joinCommunity);
      if (!joinCommunitySnapshot.exists) {
        List<dynamic>? members = [];
        members.add(userId);

        transaction.update(joinCommunity, {
          'members': members,
        });
      } else {
        List<dynamic>? members = joinCommunitySnapshot['members'];
        // check if uid exists
        bool containsUserID = members!.contains(userId);
        if (containsUserID == true) {
          // ignore
        } else {
          members.add(userId);
          transaction.update(joinCommunity, {
            'members': members,
          });
        }
      }
    });
  }

  //exit community
  Future<void> exitCommunity(String userId, String id) async {
    DocumentReference exitCommunity = community.doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot exitCommunitySnapshot =
          await transaction.get(exitCommunity);
      if (!exitCommunitySnapshot.exists) {
        List<dynamic>? members = [];
        members.remove(userId);

        transaction.update(exitCommunity, {
          'members': members,
        });
      } else {
        List<dynamic>? members = exitCommunitySnapshot['members'];
        // check if uid exists
        bool containsUserID = members!.contains(userId);
        if (containsUserID == true) {
          members.remove(userId);
          transaction.update(exitCommunity, {
            'members': members,
          });
        } else {
          members.remove(userId);
          transaction.update(exitCommunity, {
            'members': members,
          });
        }
      }
    });
  }

  //add mods to community
  Future<void> addMods(List<dynamic> uids, String id) async {
    DocumentReference addMods = community.doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot addModsSnapshot = await transaction.get(addMods);
      if (!addModsSnapshot.exists) {
        List<dynamic>? mods = [];
        mods.addAll(uids);

        transaction.update(addMods, {
          'mods': mods,
        });
      } else {
        List<dynamic>? mods = addModsSnapshot['mods'];
        // check if uid exists
        bool containsuids = mods!.contains(uids);
        if (containsuids == true) {
          // ignore
        } else {
          mods.addAll(uids);
          transaction.update(addMods, {
            'mods': mods,
          });
        }
      }
    });
  }

//delete post
  Future<void> deletePost(String postId, context) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('post')
        .where('id', isEqualTo: postId)
        .get();

    if (snapshot.size > 0) {
      DocumentReference documentRef = snapshot.docs[0].reference;
      await documentRef.delete();
    } else {}
  }

  //add to followers
  Future<void> addToFollowers(String userId, String followerId) async {
    DocumentReference addFollowers = users.doc(userId);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot addFollowersSnapshot =
          await transaction.get(addFollowers);
      if (!addFollowersSnapshot.exists) {
        List<dynamic>? followers = [];
        followers.add(followerId);

        transaction.update(addFollowers, {
          'followers': followers,
        });
      } else {
        List<dynamic>? followers = addFollowersSnapshot['followers'];
        // check if uid exists
        bool containsFollowerId = followers!.contains(followerId);
        if (containsFollowerId == true) {
          // ignore
        } else {
          followers.add(followerId);
          transaction.update(addFollowers, {
            'followers': followers,
          });
        }
      }
    });
  }

//remove from followers
  Future<void> removeFollowers(String userId, String followerId) async {
    DocumentReference removeFollowers = users.doc(userId);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot removeFollowersSnapshot =
          await transaction.get(removeFollowers);
      if (!removeFollowersSnapshot.exists) {
        List<dynamic>? followers = [];
        followers.remove(followerId);

        transaction.update(removeFollowers, {
          'followers': followers,
        });
      } else {
        List<dynamic>? followers = removeFollowersSnapshot['followers'];
        // check if uid exists
        bool containsfollowerId = followers!.contains(followerId);
        if (containsfollowerId == true) {
          followers.remove(followerId);
          transaction.update(removeFollowers, {
            'followers': followers,
          });
        } else {
          followers.remove(followerId);
          transaction.update(removeFollowers, {
            'followers': followers,
          });
        }
      }
    });
  }

  //add to chat list
  Future<void> addToChatList(String friendId, String myId) async {
    DocumentReference chat = users.doc(myId);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot chatSnapshot = await transaction.get(chat);
      if (!chatSnapshot.exists) {
        List<dynamic>? isChat = [];
        isChat.add(friendId);

        transaction.update(chat, {
          'isChat': isChat,
        });
      } else {
        List<dynamic>? isChat = chatSnapshot['isChat'];
        // check if uid exists
        bool containsfriendId = isChat!.contains(friendId);
        if (containsfriendId == true) {
          // ignore
        } else {
          isChat.add(friendId);
          transaction.update(chat, {
            'isChat': isChat,
          });
        }
      }
    });
  }

  //add to block list
  Future<void> addToBlockList(String friendId, String myId) async {
    DocumentReference user = users.doc(myId);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot blockedListSnapshot = await transaction.get(user);
      if (!blockedListSnapshot.exists) {
        List<dynamic>? blockedList = [];
        blockedList.add(friendId);

        transaction.update(user, {
          'blockedList': blockedList,
        });
      } else {
        List<dynamic>? blockedList = blockedListSnapshot['blockedList'];
        // check if uid exists
        bool containsfriendId = blockedList!.contains(friendId);
        if (containsfriendId == true) {
          // ignore
        } else {
          blockedList.add(friendId);
          transaction.update(user, {
            'blockedList': blockedList,
          });
        }
      }
    });
  }

  //remove from blocked list
  Future<void> removeblocked(String userId, String blockedUser) async {
    DocumentReference user = users.doc(userId);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot userSnapshot = await transaction.get(user);
      if (!userSnapshot.exists) {
        List<dynamic>? blockedList = [];
        blockedList.remove(blockedUser);

        transaction.update(user, {
          'blockedList': blockedList,
        });
      } else {
        List<dynamic>? blockedList = userSnapshot['blockedList'];
        // check if uid exists
        bool containsblockedUser = blockedList!.contains(blockedUser);
        if (containsblockedUser == true) {
          blockedList.remove(blockedUser);
          transaction.update(user, {
            'blockedList': blockedList,
          });
        } else {
          blockedList.remove(blockedUser);
          transaction.update(user, {
            'blockedList': blockedList,
          });
        }
      }
    });
  }

  //create artist
  Future<void> becomeArtist(Map<String, dynamic> values) async {
    String uid = values['uid'];
    String artistId = values['uid'];

    await users
        .doc(uid)
        .collection('artist')
        .doc(artistId)
        .set(values)
        .then((value) {
      DocumentReference userIsArtistRef = users.doc(uid);
      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot userIsArtistSnapshot =
            await transaction.get(userIsArtistRef);
        if (!userIsArtistSnapshot.exists) {
          transaction.update(userIsArtistRef, {
            'isArtist': true,
          });
        } else {
          transaction.update(userIsArtistRef, {
            'isArtist': true,
          });
        }
      });
    });
  }

  //  Future<void> resetUsersPassword(
  //     String userId, String userPassword, String userName) async {
  //   DocumentReference loginUsernames = loginUsername.doc(userName);
  //   FirebaseFirestore.instance.runTransaction((transaction) async {
  //     DocumentSnapshot loginUsernamesSnapshot =
  //         await transaction.get(loginUsernames);
  //     if (!loginUsernamesSnapshot.exists) {
  //       transaction.update(loginUsernames, {
  //         'userPassword': userPassword,
  //       });
  //     } else {
  //       transaction.update(loginUsernames, {
  //         'userPassword': userPassword,
  //       });
  //     }
  //   });
  // }
}
