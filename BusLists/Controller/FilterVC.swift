//
//  FilterVC.swift
//  BusLists
//
//  Created by Dhruvil Rameshbhaib Patel on 08/06/21.
//

import UIKit

protocol FilteredDataProtocol: AnyObject {
    func filteredData(sortByTitle:String,busTypeSet:[String])
}
class FilterVC: BaseVC {

    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    weak var filteredDataDelegate : FilteredDataProtocol?
    
    var selectedSortByTitle = String()
    var selectedBusTypeSet = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
      // alreadyFilteredCheck()
    }
    func setup(){
        let nibCustomTableViewCell = UINib(nibName: "FilterTableViewCell", bundle: nil)
        filterTableView.register(nibCustomTableViewCell, forCellReuseIdentifier: "FilterTableViewCell")
        
        filterTableView.dataSource = self
        filterTableView.delegate = self
        
        topView.addShadow(cornerRadius: 0, shadowRadius: 5, shadowColor: .black, shadowOpacity: 0.2, shadowOffsetHeight: 10)
    }
//    func alreadyFilteredCheck(){
//        selectedSortByTitle = UserDefaults.standard.object(forKey: "sortByTitle") as! String
//        selectedBusTypeSet = UserDefaults.standard.object(forKey: "busTypeSet") as! Set<String>
//    }
    
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func applyButtonAction(_ sender: UIButton){
        filteredDataDelegate?.filteredData(sortByTitle: selectedSortByTitle, busTypeSet: selectedBusTypeSet)
        dismiss(animated: true)
    }
}
extension FilterVC: UITableViewDataSource,UITableViewDelegate,SelectedDataProtocol{
    func selectedSortByData(title: String) {
        print(title)
        selectedSortByTitle = title
    }
    
    func selectedbusTypeData(busType: [String]) {
        print(busType)
        selectedBusTypeSet = busType
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return HEADERARRAY.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return HEADERARRAY[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FILTERCELL, for: indexPath) as! FilterTableViewCell
        cell.selectedDataDelegate = self
       // cell.showBusType = indexPath.section == 0 ? false : true
        cell.config(titleArray:TITLEARRAY[indexPath.section] , imageNameArray: IMAGEARRAY[indexPath.section],section: indexPath.section)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}



