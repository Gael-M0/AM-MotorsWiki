import 'package:dio/dio.dart';
import 'package:gaelmv/flutter_app/domain/entities/message.dart';
import 'package:gaelmv/flutter_app/infrastructure/models/yes_no_model.dart';

class GetYesNoAnswer {
  final _dio = Dio();

  Future<Message> getAnswer() async {
    final response = await _dio.get('https://yesno.wtf/api');

    final yesNoModel = YesNoModel.fromJsonMap(response.data);
    yesNoModel.image = "https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExZTltaXJxamM2am5zcW1kMGM1YWxkMWw3YTc2NHRwN25jaW44MnlwbSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/LTByspj8BjoVx9EPJq/giphy.gif";
    return yesNoModel.toMessageEntity();
  }
}
