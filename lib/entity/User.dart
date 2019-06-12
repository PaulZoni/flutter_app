
class User {

  String _id;
  String _name;
  String _userId;

  User(String id, String name) {
    this._id = id;
    this._name = name;

  }

  String getId() {
    return this._id;
  }

  String getName() {
    return this._name;
  }

  String getUserId() {
    return this._userId;
  }

  void setUserId(String userId) {
    this._userId = userId;
  }

}
