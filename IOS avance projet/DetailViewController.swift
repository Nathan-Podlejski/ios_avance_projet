//
//  DetailViewController.swift
//  IOS avance projet
//
//  Created by lpiem on 28/02/2023.
//

import UIKit

class DetailViewController: UIViewController  {
    public var landmark: Landmark?
    
    @IBOutlet weak var ImageDetail: UIImageView!
    @IBOutlet weak var LocationDetail: UILabel!
    @IBOutlet weak var DescriptionDetail: UITextView!
    @IBOutlet weak var CancelBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        title = landmark?.name
        
        ImageDetail.image = landmark?.image
        LocationDetail.text = (landmark?.city ?? "") + " " + (landmark?.state ?? "") + " " + (landmark?.park ?? "")
        DescriptionDetail.text = landmark?.description
        
    }
    
    @IBAction func CancelBtnClick(_ sender: Any) {
        dismiss(animated: true)
    }
}
