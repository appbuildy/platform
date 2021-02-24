class ValuesCast {
  dynamic data;
  ValuesCast(this.data);
  String toString() {
    switch (data.runtimeType) {
      case List:
        {
          return data[0]['url'];
        }
        break;
      default:
        {
          return data.toString();
        }
    }
  }
}
