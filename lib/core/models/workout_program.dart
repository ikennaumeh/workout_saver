class WorkoutProgram{
  final String name, image;

  WorkoutProgram({required this.name, required this.image});

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) {
    if(identical(this, other)) return true;

    return other is WorkoutProgram && other.name == name && other.image == image;
  }

  @override
  int get hashCode => name.hashCode ^ image.hashCode;


}