import 'package:flutter/material.dart';

class SelectingFriendsProvider extends ChangeNotifier {
  final _selectedFriends = [];
  bool _isSelecting = false;

  bool get isSelecting => _isSelecting;
  List get selectedFriends => _selectedFriends;
  int get length => _selectedFriends.length;

  bool start() {
    _isSelecting = true;
    _selectedFriends.clear();
    notifyListeners();
    return _isSelecting;
  }

  bool end() {
    _isSelecting = false;
    _selectedFriends.clear();
    notifyListeners();
    return _isSelecting;
  }

  List onSelectFriend({required newFriend}) {
    _selectedFriends.add(newFriend);
    notifyListeners();
    return _selectedFriends;
  }

  List onSelectFriends({required newFriend}) {
    _selectedFriends.addAll(newFriend);
    notifyListeners();
    return _selectedFriends;
  }

  List onRemoveFriend({required newFriend}) {
    _selectedFriends.removeWhere(((element) => element = newFriend));
    notifyListeners();
    return _selectedFriends;
  }
}
