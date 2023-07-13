

import '../network/local/cash_helper.dart';
import 'components.dart';


String ?token;
String ?uid;
void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}