import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../utils/constants/nums.dart';

class BreakingNewsRequest {
  final String apiKey;
  final String country;
  final String category;
  final int page;
  final int pageSize;

  BreakingNewsRequest({
    String? apiKey,
    this.country = 'ph',
    this.category = 'general',
    this.page = 1,
    this.pageSize = defaultPageSize,
  }) : apiKey = dotenv.env['API_KEY'] ?? '';
}
