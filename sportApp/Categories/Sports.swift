//
//  Sports.swift
//  sportApp
//
//  Created by Anna Melekhina on 21.03.2025.
//

import Foundation

struct DataModel {
    var headerName: String
    var subType: [String]
    var isExpandable: Bool
    var image: String
}

var categories = [
    DataModel(
        headerName: "Exercise Type",
        subType: ["cardio", "olympic_weightlifting", "plyometrics", "powerlifting", "strength", "stretching", "strongman"],
        isExpandable: false,
        image: "exercise"
    ),
    DataModel(
        headerName: "Muscle Group",
        subType: ["abdominals", "abductors", "adductors", "biceps", "calves", "chest", "forearms", "glutes", "hamstrings", "lats", "lower_back", "middle_back", "neck", "quadriceps", "traps", "triceps"],
        isExpandable: false,
        image: "muscle"
    ),
    DataModel(
        headerName: "Difficulty Level",
        subType: ["beginner", "intermediate", "expert"],
        isExpandable: false,
        image: "difficulty"
    )
]
