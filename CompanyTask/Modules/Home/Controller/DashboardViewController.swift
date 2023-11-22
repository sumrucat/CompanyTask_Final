//
//  ViewController.swift
//  CompanyTask
//
//  Created by Apple on 22/11/23.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var dashboardTableView: UITableView!
    
    let dashboardViewModel = DashboardViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        registerCell()
        fetchData()
    }
    
    private func registerCell() {
        dashboardTableView.register(UINib(nibName: CustomCell.visaDetailTableViewCell, bundle: nil), forCellReuseIdentifier: CustomCell.visaDetailTableViewCell)
    }
    
    private func fetchData() {
        dashboardViewModel.fetchEmployeeData(userName: "singhkhusbl") { isSuccess, _ in
            if isSuccess {
                DispatchQueue.main.async {
                    self.dashboardTableView.reloadData()
                }
            }else {
                //Handle error here
            }
        }
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dashboardViewModel.employeeData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.visaDetailTableViewCell) as! VisaDetailTableViewCell

        if let data = dashboardViewModel.employeeData?[indexPath.row] {
            cell.setup(data: data)
        }
        return cell
    }
}
