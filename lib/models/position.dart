class Position {
    String? stage;
    String? apt;

    Position({
        this.stage,
        this.apt,
    });

    Position copyWith({
        String? stage,
        String? apt,
    }) => 
        Position(
            stage: stage ?? this.stage,
            apt: apt ?? this.apt,
        );

    factory Position.fromJson(Map<String, dynamic> json) => Position(
        stage: json["stage"],
        apt: json["apt"],
    );

    Map<String, dynamic> toJson() => {
        "stage": stage,
        "apt": apt,
    };
}
