//
//  AirportsTableController.swift
//  AirportsList
//
//  Created by Yacob Kazal on 6/9/21.
//

import UIKit
class AirportsTableController: UITableViewController {
    private lazy var viewModel = AirportTableViewModel()
    override func viewDidLoad() {
        title = "Airports"
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = #colorLiteral(red: 0.9411764706, green: 0, blue: 0, alpha: 1)
        refreshControl?.attributedTitle = NSAttributedString(string: "Fetching Airports Data ...", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.7642649858, green: 0, blue: 0.007154861967, alpha: 1)])
        refreshControl!.addTarget(self, action: #selector(refreshAirportsData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl!)
        }
        viewModel.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        viewModel.viewDidAppear()
    }
    @objc private func refreshAirportsData(_ sender: Any) {
        viewModel.tryFetchAirpots()
    }
}

// MARK: - Data Source
extension AirportsTableController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfAirports()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let airport = viewModel.airport(forRowAt: indexPath.row)
        cell.textLabel?.text = airport.airportName
        cell.detailTextLabel?.text = airport.country.countryName
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
// MARK: - TableView Delegate
extension AirportsTableController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Show detailed view
    }
}

// MARK: - View Model
extension AirportsTableController: AirportTableDelegate{
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok!", style: .default, handler: nil))
        self.refreshControl?.endRefreshing()
        self.present(alert, animated: true)
    }
    
    func showLoading() {
        tableView.refreshControl!.beginRefreshingManually()
    }
    
    func reload() {
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
}
