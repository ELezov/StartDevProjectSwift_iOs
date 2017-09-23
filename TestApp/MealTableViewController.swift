//
//  MealTableViewController.swift
//  TestApp
//
//  Created by KODE_H6 on 23.09.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit
import os.log


class MealTableViewController: UITableViewController {


    let cellIdentifier = "MealTableViewCell"

    //MARK : Properties
    var meals = [Meal]()

    //MARK: Actions

    @IBAction func unwindToMealList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {

            // Замена строки при редактировании новыми данными
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {

                // Добавление нового объекта
                let newIndexPath = IndexPath (row: meals.count, section:0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)            }

        }


    }


    //MARK : Private methods

    func loadSampleMeals(){
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")

        guard let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }

        guard let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 4) else {
            fatalError("Unable to instantiate meal2")
        }

        guard let meal3 = Meal(name: "Borsh", photo: photo3, rating: 3) else {
            fatalError("Unable to instantiate meal3")
        }

        meals += [meal1,meal2,meal3]
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleMeals()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("The dequeued call is not an instance of MealTableViewCell.")
        }

        let meal = meals[indexPath.row]

        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating

        return cell
    }

    //MARK : Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        switch (segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? MealViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }

            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }

            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                    fatalError("The selected cell is not being displayed by the table")
            }

            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal

        default:
            fatalError("Unexpected identifier")
        }
    }


}
