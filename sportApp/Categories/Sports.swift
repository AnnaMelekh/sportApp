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

let exerciseTypes = ["cardio", "olympic_weightlifting", "plyometrics", "powerlifting", "strength", "stretching", "strongman"]

let muscleGroups = ["abdominals", "abductors", "adductors", "biceps", "calves", "chest", "forearms", "glutes", "hamstrings", "lats", "lower_back", "middle_back", "neck", "quadriceps", "traps", "triceps"]

let difficultyLevels = ["beginner", "intermediate", "expert"]


var categories = [
    DataModel(headerName: "Exercise Type", subType: exerciseTypes, isExpandable: false, image: "exercise"),
    DataModel(headerName: "Muscle Group", subType: muscleGroups, isExpandable: false, image: "muscle"),
    DataModel(headerName: "Difficulty Level", subType: difficultyLevels, isExpandable: false, image: "difficulty")
]
