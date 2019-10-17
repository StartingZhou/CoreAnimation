//
//  ViewController.swift
//  BezierAnimateTest
//
//  Created by developer on 2019/10/17.
//  Copyright © 2019 Nextop. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var offset: NSLayoutConstraint!
    @IBOutlet weak var tvContent: UITableView!
    
    var blayer: MyBezierAnimatedLayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.blayer = MyBezierAnimatedLayer.init(radius: 100, resistHeight: 100 ,strokeColor: UIColor.red, backgroundColor: UIColor.blue)
        self.blayer?.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400)
        self.view.layer.insertSublayer(blayer!, at: 0)
        self.blayer?.horizontalSpace = 110
        self.blayer?.setNeedsDisplay()
        self.tvContent.layer.masksToBounds = true
        self.tvContent.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "one")!
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var vl = 200 - scrollView.contentOffset.y - scrollView.contentInset.top
        vl = min(200, max(44, vl))
        offset.constant = vl
        self.blayer?.contentHeight = 400 - scrollView.contentOffset.y - scrollView.contentInset.top
    }
}

