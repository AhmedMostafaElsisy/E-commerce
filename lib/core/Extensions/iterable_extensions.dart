import 'package:captien_omda_customer/core/tags_feature/domain/model/tags_model.dart';

extension joinInTagsList on Iterable<TagsModel> {
  String joinTagsOfList([String separator = ""]) {
    Iterator<TagsModel> iterator = this.iterator;
    if (!iterator.moveNext()) return "";
    StringBuffer buffer = StringBuffer();
    if (separator == null || separator == "") {
      do {
        buffer.write(iterator.current.name.toString());
      } while (iterator.moveNext());
    } else {
      buffer.write(iterator.current.name.toString());
      while (iterator.moveNext()) {
        buffer.write(separator);
        buffer.write(iterator.current.name.toString());
      }
    }
    return buffer.toString();
  }
}
