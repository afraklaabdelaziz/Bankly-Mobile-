class ResponseDto {
  String status;
  String message;
  List<dynamic> data;

  ResponseDto({
    required this.status,
    required this.message,
    required this.data
});

  factory ResponseDto.fromJson(Map<dynamic, dynamic> json) {
    return ResponseDto(
        status: json['status'],
        message: json['message'],
        data: json['data']
    );
  }
}