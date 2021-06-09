//
//  FilterTableViewCell.swift
//  BusLists
//
//  Created by Dhruvil Rameshbhaib Patel on 08/06/21.
//

import UIKit
protocol SelectedDataProtocol: AnyObject {
    func selectedSortByData(title:String)
    func selectedbusTypeData(busType:[String])
}
class FilterTableViewCell: UITableViewCell {
    
    @IBOutlet var filterTypeStackView:UIStackView!
    
    @IBOutlet weak var firstImageView : UIImageView!
    @IBOutlet weak var secondImageView : UIImageView!
    @IBOutlet weak var thirdImageView : UIImageView!
    @IBOutlet weak var fourthImageView : UIImageView!
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel : UILabel!
    @IBOutlet weak var thirdLabel:  UILabel!
    @IBOutlet weak var fourthLabel : UILabel!
    
    @IBOutlet weak var firstView : UIView!
    @IBOutlet weak var secondView : UIView!
    @IBOutlet weak var thirdView : UIView!
    @IBOutlet weak var fourthView : UIView!
    
    weak var selectedDataDelegate : SelectedDataProtocol?
    var currentSection:Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func config(titleArray:[String],imageNameArray:[String],section:Int){
        
        currentSection = section
        setupGestureRecognizer()
        
        let views = filterTypeStackView.subviews.compactMap({$0 as UIView})
        for (index,view) in views.enumerated(){
            view.addShadow(cornerRadius: 20, shadowRadius: 5, shadowColor: .black, shadowOpacity: 0.2)
            switch view{
            case firstView:
                firstLabel.text = titleArray[index]
                firstImageView.image = UIImage(named: imageNameArray[index])
                firstView.accessibilityLabel = firstLabel.text
            case secondView:
                secondLabel.text = titleArray[index]
                secondImageView.image = UIImage(named: imageNameArray[index])
                secondView.accessibilityLabel = secondLabel.text
            case thirdView:
                thirdLabel.text = titleArray[index]
                thirdImageView.image = UIImage(named: imageNameArray[index])
                thirdView.accessibilityLabel = thirdLabel.text
            case fourthView:
                fourthLabel.text = titleArray[index]
                fourthImageView.image = UIImage(named: imageNameArray[index])
                fourthView.accessibilityLabel = fourthLabel.text
            default:
                print("No View Found")
                break
            }
        }
        if section == 0{
            checkPreExistingSortByFilter()
        }else{
            checkPreExistingBusTypeFilter()
        }
    }
    func checkPreExistingSortByFilter(){
        if let sortByTitle = UserDefaults.standard.object(forKey: "sortByTitle") as? String, !sortByTitle.isEmpty{
            let views = filterTypeStackView.subviews.compactMap({$0 as UIView})
            let currentView = views.filter { view in
                return view.accessibilityLabel  == sortByTitle
            }
            for view in views{
                if view == currentView.first{
                    view.backgroundColor = Color.gray
                }
            }
            selectedDataDelegate?.selectedSortByData(title: sortByTitle)
        }
    }
    func checkPreExistingBusTypeFilter(){
        if let busTypeSet = UserDefaults.standard.object(forKey: "busTypeSet") as? [String], !busTypeSet.isEmpty{
            let views = filterTypeStackView.subviews.compactMap({$0 as UIView})
            for view in views{
                if busTypeSet.contains(view.accessibilityLabel ?? "") {
                    view.backgroundColor = Color.gray
                }
            }
            selectedDataDelegate?.selectedbusTypeData(busType: busTypeSet)
        }
    }
    func setupGestureRecognizer(){
        firstView.addGestureRecognizer(setGestureRecognizer())
        secondView.addGestureRecognizer(setGestureRecognizer())
        thirdView.addGestureRecognizer(setGestureRecognizer())
        fourthView.addGestureRecognizer(setGestureRecognizer())
    }
    func setGestureRecognizer() -> UITapGestureRecognizer {
        var tapRecognizer = UITapGestureRecognizer()
        tapRecognizer = UITapGestureRecognizer (target: self, action: #selector(self.typeAction))
        return tapRecognizer
    }
    func resetViews(currentView:UIView,stackType:UIStackView){
        let views = stackType.subviews.compactMap({$0 as UIView})
        for view in views{
            if view != currentView{
                view.backgroundColor = .white
            }
        }
    }
    @objc func typeAction(sender : UITapGestureRecognizer) {
        guard let selectedView = sender.view else{ print("No Selected Views Found"); return}
        selectedView.backgroundColor = selectedView.backgroundColor == .white ? Color.gray : .white
        if currentSection == 0{
            resetViews(currentView: selectedView, stackType: filterTypeStackView)
            let sortByTitle = filterTypeStackView.subviews.compactMap({$0 as UIView}).filter({$0.backgroundColor == Color.gray}).first?.accessibilityLabel ?? ""
            selectedDataDelegate?.selectedSortByData(title: sortByTitle)
        }else{
            let busTypeSet = filterTypeStackView.subviews.compactMap({$0 as UIView}).filter({$0.backgroundColor == Color.gray}).map({$0.accessibilityLabel!})
            selectedDataDelegate?.selectedbusTypeData(busType: busTypeSet)
        }
    }
}
