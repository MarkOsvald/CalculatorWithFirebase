

class CalculationObject {
  String equation;

  CalculationObject.fromJson(Map<String, dynamic> responseBody) {
    equation = responseBody['equation'];
  }

  Map<String, dynamic> toJson() {
    Map<String,dynamic> json = Map();
    json['equation'] = equation;
    return json;
  }


}