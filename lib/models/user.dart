import 'dart:convert';

class User {
  final String id;
  final String fullname;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;

  User(
      {required this.id,
      required this.fullname,
      required this.email,
      required this.state,
      required this.city,
      required this.locality,
      required this.password,
      required this.token});
  // Tuần tự hóa: Chuyển đổi đối tượng User thành một Map
// Map: Map là một tập hợp các cặp khóa-giá trị
// Tại sao: Chuyển đối tượng thành Map là bước trung gian giúp việc tuần tự hóa
// đối tượng sang các định dạng như JSON để lưu trữ hoặc truyền tải trở nên dễ dàng hơn.

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'fullname': fullname,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password,
      'token': token,
    };
  }

  // Tuần tự hóa: Chuyển đổi Map thành chuỗi Json
// Phương thức này trực tiếp mã hóa dữ liệu từ Map thành chuỗi Json bằng cách sử dụng phương thức json.encode
  String toJson() => json.encode(toMap());

  // Giải tuần tự: Chuyển đổi Map thành đối tượng User
// Mục đích - Xử lý và sử dụng: Khi dữ liệu được chuyển đổi thành đối tượng User,
// nó có thể được xử lý và sử dụng dễ dàng trong ứng dụng. Ví dụ,
// chúng ta có thể hiển thị tên đầy đủ, email của người dùng trên giao diện, hoặc
// lưu dữ liệu cục bộ.

// Constructor factory nhận vào một Map (thường lấy từ một đối tượng JSON)
// và chuyển nó thành đối tượng User. Nếu một trường không có trong Map,
// giá trị mặc định sẽ là chuỗi rỗng.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['_id'] as String? ?? "",
        fullname: map['fullname'] as String? ?? "",
        email: map['email'] as String? ?? "",
        state: map['state'] as String? ?? "",
        city: map['city'] as String? ?? "",
        locality: map['locality'] as String? ?? "",
        password: map['password'] as String? ?? "",
        token: map['token'] as String? ?? "");
  }

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
