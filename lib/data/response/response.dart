enum Status {
  LOADING,
  SUCCESS,
  ERROR,
  INITIAL,
}

class Response<T> {
  Status? status;
  T? data;
  String? message;

  Response(this.status, this.data, this.message);

  Response.loading() : status = Status.LOADING;

  Response.success(this.data) : status = Status.SUCCESS;

  Response.error(this.message) : status = Status.ERROR;

  Response.initial() : status = Status.INITIAL;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
