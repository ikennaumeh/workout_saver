class WorkOut{
  String? name, weight, repetition, sets, photoUrl;
  int? id;

  WorkOut({
    this.id,
    this.name,
    this.weight,
    this.repetition,
    this.sets,
    this.photoUrl,
  });

  static WorkOut? fromJSON(Map<String, dynamic>? data) {
    if(data == null) return null;

    return WorkOut(
      id: data["id"],
      name: data["name"],
      weight: data["weight"],
      repetition: data["repetition"],
      sets: data["sets"],
      photoUrl: data["photoUrl"],
    );
  }

  Map<String, dynamic> toJSON(){
    return {
      "id": id,
      "name": name,
      "weight": weight,
      "repetition": repetition,
      "sets": sets,
      "photoUrl":photoUrl
    };
  }

}