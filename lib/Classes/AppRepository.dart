import 'package:cloud_firestore/cloud_firestore.dart';
import 'UserNew.dart';

class UserRepository {
  static CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  static Future<UserNew?> getUserById(String userId) async {
    try {
      final DocumentSnapshot docSnapshot = await usersCollection.doc(userId).get();
      if (docSnapshot.exists) {
        final Map<String, dynamic> userData =
        docSnapshot.data() as Map<String, dynamic>;
        print("User Data: $userData");

        final UserNew user = UserNew(
          id: userData['id'] != null ? userData['id'] : '',
          accountType: userData['account_type'] != null ? userData['account_type'] : '',
          address: userData['address'] != null ? userData['address'] : '',
          device: userData['device'] != null ? userData['device'] : '',
          email: userData['email'] != null ? userData['email'] : '',
          lastLogin: userData['last_login'] != null ? userData['last_login'] : '',
          name: userData['name'] != null ? userData['name'] : '',
          phone: userData['phone'] != null ? userData['phone'] : '',
          role: userData['role'] != null ? userData['role'] : '',
          subscriptionDate: userData['subscription_date'] != null ? userData['subscription_date'] : '',
          region: userData['region'] != null ? userData['region'] : '',
          companyName: userData['company_name'] != null ? userData['company_name'] : '',
          contactPersonLocation: userData['contact_person_location'] != null ? userData['contact_person_location'] : '',
          contactPersonPhone: userData['contact_person_phone'] != null ? userData['contact_person_phone'] : '',
          locationPhone: userData['location_phone'] != null ? userData['location_phone'] : '',
          ownerPhone: userData['owner_phone'] != null ? userData['owner_phone'] : '',
          storeAddress: userData['store_address'] != null ? userData['store_address'] : '',
          storeEmail: userData['store_email'] != null ? userData['store_email'] : '',
          storeName: userData['store_name'] != null ? userData['store_name'] : '',
          subscriptionExpires: userData['subscription_expires'] != null ? userData['subscription_expires'] : '',
          createdAt: userData['created_at'] != null ? (userData['created_at'] as Timestamp).toDate() : DateTime.now(),
          updatedAt: userData['updated_at'] != null ? (userData['updated_at'] as Timestamp).toDate() : DateTime.now(),

          // createdAt: userData['created_at'] != null ? DateTime.parse(userData['created_at']) : DateTime.now(),
          // updatedAt: userData['updated_at'] != null ? DateTime.parse(userData['updated_at']) : DateTime.now(),

          isBlocked: userData['is_blocked'] != null ? userData['is_blocked'] : false,
          isPaidUser: userData['is_paid_user'] != null ? userData['is_paid_user'] : false,
          loginStatus: userData['login_status'] != null ? userData['login_status'] : false,
          subscribeInventory: userData['subscribeInventory'] != null ? userData['subscribeInventory'] : false,

          screen1: Screen1(
            boxSettings: (userData['screen1']['box_settings'] as List<dynamic>)
                .map((boxData) {
              return Box(
                game_image: boxData['game_image'] != null ? boxData['game_image'] : '',
                game_no: boxData['game_no'] != null ? boxData['game_no'] : '',
                ticket_no: boxData['ticket_no'] != null ? boxData['ticket_no'] : '',
                ticket_value: boxData['ticket_value'] != null ? boxData['ticket_value'] : '',
                pack_size: boxData['pack_size'] != null ? boxData['pack_size'] : '',
                animation: boxData['animation'] != null ? boxData['animation'] : false,
              );
            }).toList(),
            emptyBox: userData['screen1']['empty_box'] != null ? userData['screen1']['empty_box'] : '',
            emptyBoxCustomImage: userData['screen1']['empty_box_custom_image'] != null ? userData['screen1']['empty_box_custom_image'] : '',
            orientation: userData['screen1']['orientation'] != null ? userData['screen1']['orientation'] : '',
            showHeader: userData['screen1']['show_header'] != null ? userData['screen1']['show_header'] : false,
            totalBoxes: userData['screen1']['total_boxes'] != null ? userData['screen1']['total_boxes'] : 0,
          ),

          screen2: Screen1(
            boxSettings: (userData['screen2']['box_settings'] as List<dynamic>)
                .map((boxData) {
              return Box(
                game_image: boxData['game_image'] != null ? boxData['game_image'] : '',
                game_no: boxData['game_no'] != null ? boxData['game_no'] : '',
                ticket_no: boxData['ticket_no'] != null ? boxData['ticket_no'] : '',
                ticket_value: boxData['ticket_value'] != null ? boxData['ticket_value'] : '',
                pack_size: boxData['pack_size'] != null ? boxData['pack_size'] : '',
                animation: boxData['animation'] != null ? boxData['animation'] : false,
              );
            }).toList(),
            emptyBox: userData['screen2']['empty_box'] != null ? userData['screen2']['empty_box'] : '',
            emptyBoxCustomImage: userData['screen2']['empty_box_custom_image'] != null ? userData['screen2']['empty_box_custom_image'] : '',
            orientation: userData['screen2']['orientation'] != null ? userData['screen2']['orientation'] : '',
            showHeader: userData['screen2']['show_header'] != null ? userData['screen2']['show_header'] : false,
            totalBoxes: userData['screen2']['total_boxes'] != null ? userData['screen2']['total_boxes'] : 0,
          ),

          screen3: Screen1(
            boxSettings: (userData['screen3']['box_settings'] as List<dynamic>)
                .map((boxData) {
              return Box(
                game_image: boxData['game_image'] != null ? boxData['game_image'] : '',
                game_no: boxData['game_no'] != null ? boxData['game_no'] : '',
                ticket_no: boxData['ticket_no'] != null ? boxData['ticket_no'] : '',
                ticket_value: boxData['ticket_value'] != null ? boxData['ticket_value'] : '',
                pack_size: boxData['pack_size'] != null ? boxData['pack_size'] : '',
                animation: boxData['animation'] != null ? boxData['animation'] : false,
              );
            }).toList(),
            emptyBox: userData['screen3']['empty_box'] != null ? userData['screen3']['empty_box'] : '',
            emptyBoxCustomImage: userData['screen3']['empty_box_custom_image'] != null ? userData['screen3']['empty_box_custom_image'] : '',
            orientation: userData['screen3']['orientation'] != null ? userData['screen3']['orientation'] : '',
            showHeader: userData['screen3']['show_header'] != null ? userData['screen3']['show_header'] : false,
            totalBoxes: userData['screen3']['total_boxes'] != null ? userData['screen3']['total_boxes'] : 0,
          ),

          screen4: Screen1(
            boxSettings: (userData['screen4']['box_settings'] as List<dynamic>)
                .map((boxData) {
              return Box(
                game_image: boxData['game_image'] != null ? boxData['game_image'] : '',
                game_no: boxData['game_no'] != null ? boxData['game_no'] : '',
                ticket_no: boxData['ticket_no'] != null ? boxData['ticket_no'] : '',
                ticket_value: boxData['ticket_value'] != null ? boxData['ticket_value'] : '',
                pack_size: boxData['pack_size'] != null ? boxData['pack_size'] : '',
                animation: boxData['animation'] != null ? boxData['animation'] : false,
              );
            }).toList(),
            emptyBox: userData['screen4']['empty_box'] != null ? userData['screen4']['empty_box'] : '',
            emptyBoxCustomImage: userData['screen4']['empty_box_custom_image'] != null ? userData['screen4']['empty_box_custom_image'] : '',
            orientation: userData['screen4']['orientation'] != null ? userData['screen4']['orientation'] : '',
            showHeader: userData['screen4']['show_header'] != null ? userData['screen4']['show_header'] : false,
            totalBoxes: userData['screen4']['total_boxes'] != null ? userData['screen4']['total_boxes'] : 0,
          ),

          screen5: userData['screen5'] != null ? Screen3(mediaType: userData['screen5']['media_type'] != null ? userData['screen5']['media_type'] : '',
            mediaUrl: userData['screen5']['media_url'] != null ? userData['screen5']['media_url'] : '',
            orientation: userData['screen5']['orientation'] != null ? userData['screen5']['orientation'] : '',
          )
              : Screen3(
            mediaType: '',
            mediaUrl: '',
            orientation: '',
          ),


          screen6: userData['screen6'] != null ? Screen3(mediaType: userData['screen6']['media_type'] != null ? userData['screen6']['media_type'] : '',
            mediaUrl: userData['screen6']['media_url'] != null ? userData['screen6']['media_url'] : '',
            orientation: userData['screen6']['orientation'] != null ? userData['screen6']['orientation'] : '',
          )
              : Screen3(
            mediaType: '',
            mediaUrl: '',
            orientation: '',
          ),

          screen7: userData['screen7'] != null ? Screen3(mediaType: userData['screen7']['media_type'] != null ? userData['screen7']['media_type'] : '',
            mediaUrl: userData['screen7']['media_url'] != null ? userData['screen7']['media_url'] : '',
            orientation: userData['screen7']['orientation'] != null ? userData['screen7']['orientation'] : '',
          )
              : Screen3(
            mediaType: '',
            mediaUrl: '',
            orientation: '',
          ),

        );
        return user;
      }
      return null; // User not found
    } catch (e) {
      print('Error fetching user: $e');
      return null; // Handle error
    }
  }
}


