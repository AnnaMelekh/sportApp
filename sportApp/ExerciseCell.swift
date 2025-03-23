//
//  ExerciseCell.swift
//  sportApp
//
//  Created by Anna Melekhina on 23.03.2025.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    let nameLabel = UILabel()
    let typeLabel = UILabel()
    let muscleLabel = UILabel()
    let equipmentLabel = UILabel()
    let difficultyLabel = UILabel()
    let instructionsLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let stack = UIStackView(arrangedSubviews: [nameLabel, typeLabel, muscleLabel, equipmentLabel, difficultyLabel, instructionsLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        instructionsLabel.numberOfLines = 0  
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with exercise: SportsModel) {
        nameLabel.text = "Name: \(exercise.name)"
        typeLabel.text = "Type: \(exercise.type)"
        muscleLabel.text = "Muscle: \(exercise.muscle)"
        equipmentLabel.text = "Equipment: \(exercise.equipment)"
        difficultyLabel.text = "Difficulty: \(exercise.difficulty)"
        instructionsLabel.text = "Instructions: \(exercise.instructions)"
    }
}
