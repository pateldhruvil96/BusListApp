//
//  BusListTableViewCell.swift
//  BusLists
//
//  Created by Dhruvil Rameshbhaib Patel on 07/06/21.
//

import UIKit
import CoreData

class BusListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var travelsNameLabel: UILabel!
    @IBOutlet weak var travelsLogoImageView: ImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var sourceTimeLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var fareLabel: UILabel!
    @IBOutlet weak var destinationTimeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var travelsTypeLabel: UILabel!
    @IBOutlet weak var baseView:UIView!
    
    var busType:String = ""
    private var task: URLSessionDataTask?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    func setupUI(){
        baseView.addShadow(cornerRadius: 20, shadowRadius: 5, shadowColor: .black, shadowOpacity: 0.2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.travelsLogoImageView.image = nil
        task?.cancel()
        task = nil
    }
    func config(details:SeachedItems,baseLogoStringURL:String,loadImageFromDb:Bool){
        travelsNameLabel.text = details.travelsName
        sourceLabel.text = details.source
        destinationLabel.text = details.destination
        sourceTimeLabel.text = details.arrivalTime.formateDate()
        destinationTimeLabel.text = details.departureTime.formateDate()
        fareLabel.text = details.currency + " " + String(details.busFair)
        ratingLabel.text = String(details.ratingModel.rating)
        
        if details.busTypeModel.isAC && details.busTypeModel.isSeater{
            busType = "AC Seater"
        }else if details.busTypeModel.isAC && details.busTypeModel.isSleeper{
            busType = "AC Sleeper"
        }else if details.busTypeModel.isNonAC && details.busTypeModel.isSeater{
            busType = "Non-AC Seater"
        }else if details.busTypeModel.isNonAC && details.busTypeModel.isSleeper{
            busType = "Non-AC Sleeper"
        }
        travelsTypeLabel.text = busType
        if !loadImageFromDb{
            
            if task == nil {
                // Ignore calls when reloading
                let urlString = baseLogoStringURL + details.busLogoURL
                task = travelsLogoImageView.downloadImage(from: urlString, saveAsCache: true)
                   
            }
            
        }
    }
}

