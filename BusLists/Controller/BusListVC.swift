//
//  BusListVC.swift
//  BusLists
//
//  Created by Dhruvil Rameshbhaib Patel on 07/06/21.
//

import UIKit

class BusListVC: BaseVC {
    
    @IBOutlet weak var busListTableView: UITableView!
    @IBOutlet weak var emptySearchView: UIView!
    @IBOutlet weak var emptySearchLabel : UILabel!
    @IBOutlet weak var topView: UIView!
    
    var list = [SeachedItems]()
    var baseLogoStringURL : String = ""
    var savedItemsDict = [Int:SeachedItems]()
    var imageDataArray = [ImageSave]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Reachability.isConnectedToNetwork(){
            callAPI()
        }else{
            fetchFromDB()
        }
    }
    func fetchFromDB(){
        do{
            let busList = try context.fetch(BusList.fetchRequest()) as! [BusList]
            
            for (index,item) in busList.enumerated(){
                var isAc = Bool()
                var isNonAc = Bool()
                var isSeater = Bool()
                var isSleeper = Bool()
                let busType = item.busType
                if busType.contains("AC"){
                    isAc = true
                }
                if busType.contains("Non-AC"){
                    isNonAc = true
                }
                if busType.contains("Seater"){
                    isSeater = true
                }
                if busType.contains("Sleeper"){
                    isSleeper = true
                }
                savedItemsDict[index] = SeachedItems(source: item.source, destination: item.destination, departureTime: item.destinationTime, arrivalTime: item.sourceTime, travelsName: item.travelsName, busFair: Int(item.fare), currency: item.currency, rating: Rating(rating: item.rating), busLogoURL: "", busTypeModel: BusType(isAc: isAc, isNonAC: isNonAc, isSeater: isSeater, isSleeper: isSleeper))
            }
            for item in savedItemsDict{
                list.append(item.value)
            }
            if list.isEmpty{
                alert(title: "Oops", message: "Not connected with internet & no data found offline")
                emptySearchView.isHidden = false
            }
            self.busListTableView.reloadData()
            
        }catch{
            print(error)
        }
        
        //Fetching image data array
        do{
            imageDataArray = try context.fetch(ImageSave.fetchRequest()) as! [ImageSave]
            self.busListTableView.reloadData()
        }catch{
            print(error)
        }
    }
    func setup(){
        let nibCustomTableViewCell = UINib(nibName: BUSLISTCELL, bundle: nil)
        busListTableView.register(nibCustomTableViewCell, forCellReuseIdentifier: BUSLISTCELL)
        
        busListTableView.dataSource = self
        busListTableView.delegate = self
        
        topView.addShadow(cornerRadius: 0, shadowRadius: 5, shadowColor: .black, shadowOpacity: 0.2, shadowOffsetHeight: 10)
        
        emptySearchView.isHidden = true
        
    }
    func callAPI(){
        guard let url = URL(string: BASEURL + EndPoint.route.rawValue) else {
            return
        }
        LoadingOverlay.shared.showOverlay(view: view)
        APIConnection.shared.makeRequest(toURL: url , params: ["":""], method: .Get) { [weak self] (error, data) in
            LoadingOverlay.shared.hideOverlayView()
            if let err = error {
                //Show error
                print("got error \(err)")
                let alertController = self?.genericRetryAlert(retry:  { (action) in
                    self?.callAPI()
                })
                self?.present(alertController ?? UIAlertController(), animated: true, completion: nil)
                return
            }
            
            guard let responseData = data else {
                let alertController = self?.genericRetryAlert(retry:  { (action) in
                    self?.callAPI()
                })
                self?.present(alertController ?? UIAlertController(), animated: true, completion: nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            let responseModel = try? jsonDecoder.decode(ListModel.self, from: responseData)
            if let resp = responseModel {
                self?.list = resp.totalList
                self?.baseLogoStringURL = resp.metaData.busLogoBaseURL
                self?.saveToCoreData()
                self?.busListTableView.reloadData()
                
            }
        }
        
    }
    @IBAction func filterButtonAction(_ sender: UIButton) {
        let selectedVC = self.storyboard!.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        selectedVC.filteredDataDelegate = self
        present(selectedVC, animated: true)
    }
    @IBAction func refreshAPIButtonAction(_sender: UIButton){
        emptySearchView.isHidden = true
        if Reachability.isConnectedToNetwork(){
            resetDefaults()
            deleteAllRecords(entityName: BUSLISTENTITYNAME)
            deleteAllRecords(entityName: IMAGESAVEENTITYNAME)
            callAPI()
        }else{
            fetchFromDB()
        }
    }
    
    
}
extension BusListVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BUSLISTCELL, for: indexPath) as! BusListTableViewCell
        cell.config(details: list[indexPath.row], baseLogoStringURL: baseLogoStringURL, loadImageFromDb: Reachability.isConnectedToNetwork() ? false : true)
        if !Reachability.isConnectedToNetwork() && !imageDataArray.isEmpty{
            cell.travelsLogoImageView.image = UIImage(data: (imageDataArray[indexPath.row].image))
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
extension BusListVC:FilteredDataProtocol{
    func filteredData(sortByTitle: String, busTypeSet: [String]) {
        if !sortByTitle.isEmpty{
            if sortByTitle == TITLEARRAY[0][0]{
                list = list.sorted(by: { currData, nextData in
                    return currData.ratingModel.rating > nextData.ratingModel.rating
                })
            }else if sortByTitle == TITLEARRAY[0][1]{
                list = list.sorted(by: { currData, nextData in
                    return currData.arrivalTime.formateReturnDate().timeIntervalSince1970 < nextData.arrivalTime.formateReturnDate().timeIntervalSince1970
                })
            }else if sortByTitle == TITLEARRAY[0][2]{
                list = list.sorted(by: { currData, nextData in
                    return currData.arrivalTime.formateReturnDate().timeIntervalSince1970 > nextData.arrivalTime.formateReturnDate().timeIntervalSince1970
                })
            }else if sortByTitle == TITLEARRAY[0][3]{
                list = list.sorted(by: { currData, nextData in
                    return currData.busFair < nextData.busFair
                })
            }
        }
        if !busTypeSet.isEmpty{
            for item in busTypeSet{
                switch item{
                case TITLEARRAY[1][0]:
                    list = list.filter({$0.busTypeModel.isAC})
                case TITLEARRAY[1][1]:
                    list = list.filter({$0.busTypeModel.isNonAC})
                case TITLEARRAY[1][2]:
                    list = list.filter({$0.busTypeModel.isSeater})
                case TITLEARRAY[1][3]:
                    list = list.filter({$0.busTypeModel.isSleeper})
                default:
                    break
                }
            }
        }
        UserDefaults.standard.set(sortByTitle, forKey: SORTBYTITLE)
        UserDefaults.standard.set(busTypeSet, forKey: BUSTYPESET)
        saveToCoreData()
        emptySearchView.isHidden = list.isEmpty ? false : true
        busListTableView.reloadData()
    }
    func saveToCoreData(){
        deleteAllRecords(entityName: BUSLISTENTITYNAME)
        
        for item in list{
            let busList  = BusList(context: context)
            busList.travelsName = item.travelsName
            busList.source = item.source
            busList.destination = item.destination
            busList.sourceTime = item.arrivalTime
            busList.destinationTime = item.departureTime
            busList.fare = Int64(item.busFair)
            busList.rating = item.ratingModel.rating
            busList.currency = item.currency
            
            var busType:String = ""
            if item.busTypeModel.isAC && item.busTypeModel.isSeater{
                busType = "AC Seater"
            }else if item.busTypeModel.isAC && item.busTypeModel.isSleeper{
                busType = "AC Sleeper"
            }else if item.busTypeModel.isNonAC && item.busTypeModel.isSeater{
                busType = "Non-AC Seater"
            }else if item.busTypeModel.isNonAC && item.busTypeModel.isSleeper{
                busType = "Non-AC Sleeper"
            }
            busList.busType = busType
            
            do{
                try context.save()
            }catch{
                print(error)
            }
        }
    }
}
