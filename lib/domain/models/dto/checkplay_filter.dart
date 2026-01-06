// ignore_for_file: public_member_api_docs, sort_constructors_first
class CheckplayFilter {
  String query = "";
  String categoryId = "";
  String status = "";
  int page = 0;
  int size = 10;
  String sort = '';

  CheckplayFilter({
    this.query = "",
    this.categoryId = "",
    this.status = "",
    this.page = 0,
    this.size = 10,
    this.sort = "",
  });

  @override
  String toString() {
    return 'CheckplayFilter(query: $query, categoryId: $categoryId, status: $status, page: $page, size: $size, sort: $sort)';
  }
}
