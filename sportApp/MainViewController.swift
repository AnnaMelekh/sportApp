//
//  ViewController.swift
//  sportApp
//
//  Created by Anna Melekhina on 21.03.2025.
//

import UIKit

final class MainViewController: UIViewController {
    
    var networkService = NetworkService()
        var exercises: [SportsModel] = []
    
    private lazy var tblView = UITableView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose category:"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.text = "Search for exercises:"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var muscleButton = createPickerButton(title: "Muscles")
    private lazy var exerciseButton = createPickerButton(title: "Exercise")
    private lazy var difficultyButton = createPickerButton(title: "Level")

    private lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.isHidden = true
        picker.backgroundColor = .white
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private var data = categories
    private var currentOptions: [String] = []
    private var currentButton: UIButton?
    var selectedMuscle: String?
    var selectedExercise: String?
    var selectedLevel: String?
    var selectedCategory: String?
    var selectedValue: String?
    
    private lazy var goButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.isEnabled = false
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        tblView.delegate = self
        tblView.dataSource = self
        networkService.delegate = self

        setupTableView()
        
    }
}

private extension MainViewController {
    func setupTableView() {
        view.addSubview(tblView)
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        tblView.separatorStyle = .none
        NSLayoutConstraint.activate([
            tblView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            tblView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tblView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tblView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setupUI(){
        view.backgroundColor = .white
      
        view.addSubview(titleLabel)
        view.addSubview(searchLabel)
        view.addSubview(muscleButton)
        view.addSubview(exerciseButton)
        view.addSubview(difficultyButton)

        view.addSubview(picker)
        view.addSubview(goButton)

        NSLayoutConstraint.activate([
            
            searchLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchLabel.heightAnchor.constraint(equalToConstant: 50),
            searchLabel.widthAnchor.constraint(equalToConstant: 200),
            
            muscleButton.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 0),
            exerciseButton.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 0),
            difficultyButton.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 0),
            
            muscleButton.heightAnchor.constraint(equalToConstant: 50),
            exerciseButton.heightAnchor.constraint(equalToConstant: 50),
            difficultyButton.heightAnchor.constraint(equalToConstant: 50),
            
            muscleButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            exerciseButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            difficultyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            
            exerciseButton.leadingAnchor.constraint(equalTo: muscleButton.trailingAnchor, constant: 5),
            difficultyButton.leadingAnchor.constraint(equalTo: exerciseButton.trailingAnchor, constant: 5),

            goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goButton.topAnchor.constraint(equalTo: difficultyButton.bottomAnchor, constant: 5),
            goButton.widthAnchor.constraint(equalToConstant: 100),
            goButton.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: goButton.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            
            picker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            picker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            picker.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func createPickerButton(title: String) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.title = title
        config.baseForegroundColor = .systemGray
        config.image = UIImage(systemName: "chevron.down")
        config.imagePlacement = .trailing
        config.imagePadding = 8
        config.buttonSize = .small
        let button = UIButton(configuration: config, primaryAction: nil)
        button.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func updateGoButtonState() {
        if selectedMuscle != nil || selectedExercise != nil || selectedLevel != nil {
            goButton.isEnabled = true
            goButton.backgroundColor = .systemBlue
        } else {
            goButton.isEnabled = false
            goButton.backgroundColor = .gray
        }
    }
    
    @objc private func goButtonTapped() {
        networkService.performRequest(type: selectedExercise,
                                             muscle: selectedMuscle,
                                             difficulty: selectedLevel) { _ in
               }
    }
    
    @objc func showPicker(sender: UIButton) {
        currentButton = sender
        
        switch sender {
        case muscleButton:
            currentOptions = muscleGroups
            
        case exerciseButton:
            currentOptions = exerciseTypes
            
        case difficultyButton:
            currentOptions = difficultyLevels
            
        default:
            return
        }
        
        picker.reloadAllComponents()
        picker.selectRow(0, inComponent: 0, animated: false)
        picker.isHidden = false
        view.bringSubviewToFront(picker)
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: tblView.frame.size.width, height: 55))
        headerView.secIndex = section
        headerView.delegate = self
        headerView.titleLabel.text = data[section].headerName
        headerView.leftImageView.image = UIImage(named: data[section].image)
        headerView.toggleChevron(isExpandable: data[section].isExpandable)
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data[section].isExpandable {
            return 1
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {
                return UITableViewCell()
            }
        let subcategories = data[indexPath.section].subType
        let categoryName = data[indexPath.section].headerName

        cell.delegate = self
        cell.configure(with: subcategories, categoryName: categoryName)
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return data[indexPath.section].isExpandable ? 350 : 0
        }
}

extension MainViewController: HeaderDelegate {
    
    func callHeader(idx: Int) {
        data[idx].isExpandable.toggle()
        tblView.reloadSections ([idx], with: .automatic)
    }
}


extension MainViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        currentOptions.count
    }
}

extension MainViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = .black
        label.text = currentOptions[row]
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let currentButton else { return }
                let selectedDescription = currentOptions[row]

                currentButton.setTitle(selectedDescription, for: .normal)

                switch currentButton {
                case muscleButton:
                    selectedMuscle = selectedDescription

                case exerciseButton:
                    selectedExercise = selectedDescription

                case difficultyButton:
                    selectedLevel = selectedDescription

                default:
                    break
                }

        updateGoButtonState()
                pickerView.isHidden = true
            
        }
}

extension MainViewController: NetworkServiceDelegate {
    func didUpdateData(sports: [SportsModel]) {
        self.exercises = sports
        let exerciseVC = ExerciseViewController()
        exerciseVC.exercises = sports
        exerciseVC.modalPresentationStyle = .popover
        present(exerciseVC, animated: true, completion: nil)
    }

    func didFailWithError(error: Error) {
        print("Ошибка загрузки: \(error)")
    }
}

extension MainViewController: CategoryCellDelegate {
    func didSelectSubcategory(_ value: String, for category: String) {
        selectedCategory = category
        selectedValue = value
        if category.lowercased().contains("muscle") {
            networkService.performRequest(muscle: value) { [weak self] result in
                self?.openExerciseVC(with: result)
            }
        } else if category.lowercased().contains("type") {
            networkService.performRequest(type: value) { [weak self] result in
                self?.openExerciseVC(with: result)
            }
        } else if category.lowercased().contains("difficulty") {
            networkService.performRequest(difficulty: value) { [weak self] result in
                self?.openExerciseVC(with: result)
            }
        }
    }
    func openExerciseVC(with data: [SportsModel]) {
        DispatchQueue.main.async {
            let vc = ExerciseViewController()
            vc.exercises = data
            vc.modalPresentationStyle = .popover
            self.present(vc, animated: true)
        }
    }
}

#Preview { MainViewController() }
