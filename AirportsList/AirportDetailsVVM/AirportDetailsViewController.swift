//
//  DetailsViewController.swift
//  AirportsList
//
//  Created by Yacob Kazal on 6/9/21.
//

import UIKit

class AirportDetailsViewController: UITableViewController {
    var viewModel: AirportDetailsViewModel?
    override func viewDidLoad() {
        title = "Details"
        tableView.allowsSelection = false
    }
}

// MARK: - Data Source
extension AirportDetailsViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfRows() ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailsCell
        let details = viewModel?.details(forRowAt: indexPath.row)
        cell.label.text = details?.0
        cell.info?.text = details?.1
        return cell
    }
}
